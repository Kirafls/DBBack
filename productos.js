const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');
const jwt = require('jsonwebtoken'); // Faltaba importar jwt

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

const dbConfig = {
  host: 'localhost',
  user: 'root', 
  password: '', 
  database: 'tiendabd' 
};


// Crear conexión a la base de datos
async function createConnection() {
  try {
    const connection = await mysql.createConnection(dbConfig);
    console.log('Conectado a MySQL');
    return connection;
  } catch (error) {
    console.error('Error al conectar con MySQL:', error);
    throw error;
  }
}

// Crear pool de conexiones en lugar de una sola conexión
const dbPool = mysql.createPool(dbConfig);

// Definir la clave secreta para JWT (debería estar en variables de entorno)
const SECRET_KEY = 'tu_clave_secreta_super_segura'; // Cambia esto por una clave segura

// Función para buscar usuario (ya la tienes correcta)
async function buscarUser(connection, data) {
  const isIdSearch = data.hasOwnProperty('id');
  const searchValue = isIdSearch ? data.id : data.user;

  let query = "SELECT `Id`, `pass`, `user`, `permiso` FROM empleado WHERE ";
  query += isIdSearch ? "`Id` = ?" : "`user` = ?";

  const [rows] = await connection.execute(query, [searchValue]);
  return rows;
}
// Ruta de login
app.post('/tienda/login', async (req, res) => {
  const { username, password, id } = req.body;

  if ((!username && !id) || !password) {
    return res.status(400).json({ message: 'Se requiere (username o id) y password' });
  }

  try {
    const connection = await dbPool.getConnection();
    const searchCriteria = username ? { user: username } : { id };

    const result = await buscarUser(connection, searchCriteria);
    connection.release();

    if (result.length === 0) {
      return res.status(401).json({ message: 'Credenciales inválidas' });
    }

    const user = result[0];

    // Comparación de contraseña sin hash (usa bcrypt.compare si es hash)
    if (password !== user.pass) {
      return res.status(401).json({ message: 'Credenciales inválidas' });
    }

    // Crear JWT
    const token = jwt.sign({
      id: user.Id,
      username: user.user,
      permiso: user.permiso
    }, SECRET_KEY, { expiresIn: '1h' });

    res.json({
      token,
      user: {
        id: user.Id,
        username: user.user,
        permiso: user.permiso
      }
    });

  } catch (err) {
    console.error('Error en login:', err);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
});



// RUTAS PARA PRODUCTOS

// GET - Obtener todos los productos
app.get('/api/productos', async (req, res) => {
  try {
    const connection = await createConnection();
    const [rows] = await connection.execute(`
      SELECT 
        id_producto as id,
        nombre,
        descripcion,
        precio,
        cantidad as stock,
        unidad,
        categoria,
        activo
      FROM Producto 
      ORDER BY nombre
    `);
    await connection.end();
    res.json(rows);
  } catch (error) {
    console.error('Error al obtener productos:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

// GET - Obtener un producto por ID
app.get('/api/productos/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const connection = await createConnection();
    const [rows] = await connection.execute(`
      SELECT 
        id_producto as id,
        nombre,
        descripcion,
        precio,
        cantidad as stock,
        unidad,
        categoria,
        activo
      FROM Producto 
      WHERE id_producto = ?
    `, [id]);
    await connection.end();
    
    if (rows.length === 0) {
      return res.status(404).json({ error: 'Producto no encontrado' });
    }
    
    res.json(rows[0]);
  } catch (error) {
    console.error('Error al obtener producto:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

// POST - Crear nuevo producto
app.post('/api/productos', async (req, res) => {
  try {
    const { nombre, descripcion, precio, stock, unidad, categoria, activo } = req.body;
    
    // Validaciones básicas
    if (!nombre || !precio || !stock || !unidad) {
      return res.status(400).json({ error: 'Faltan campos obligatorios' });
    }
    
    const connection = await createConnection();
    const [result] = await connection.execute(`
      INSERT INTO Producto (nombre, descripcion, precio, cantidad, unidad, categoria, activo)
      VALUES (?, ?, ?, ?, ?, ?, ?)
    `, [nombre, descripcion || null, precio, stock, unidad, categoria || null, activo !== false]);
    
    await connection.end();
    
    res.status(201).json({
      id: result.insertId,
      nombre,
      descripcion,
      precio,
      stock,
      unidad,
      categoria,
      activo: activo !== false,
      message: 'Producto creado correctamente'
    });
  } catch (error) {
    console.error('Error al crear producto:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

// PUT - Actualizar producto
app.put('/api/productos/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { nombre, descripcion, precio, stock, unidad, categoria, activo } = req.body;
    
    // Validaciones básicas
    if (!nombre || !precio || !stock || !unidad) {
      return res.status(400).json({ error: 'Faltan campos obligatorios' });
    }
    
    const connection = await createConnection();
    const [result] = await connection.execute(`
      UPDATE Producto 
      SET nombre = ?, descripcion = ?, precio = ?, cantidad = ?, unidad = ?, categoria = ?, activo = ?
      WHERE id_producto = ?
    `, [nombre, descripcion || null, precio, stock, unidad, categoria || null, activo !== false, id]);
    
    await connection.end();
    
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Producto no encontrado' });
    }
    
    res.json({
      id: parseInt(id),
      nombre,
      descripcion,
      precio,
      stock,
      unidad,
      categoria,
      activo: activo !== false,
      message: 'Producto actualizado correctamente'
    });
  } catch (error) {
    console.error('Error al actualizar producto:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

// DELETE - Eliminar producto
app.delete('/api/productos/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const connection = await createConnection();
    const [result] = await connection.execute(`
      DELETE FROM Producto WHERE id_producto = ?
    `, [id]);
    await connection.end();
    
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Producto no encontrado' });
    }
    
    res.json({ message: 'Producto eliminado correctamente' });
  } catch (error) {
    console.error('Error al eliminar producto:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

app.patch('/api/productos/:id/estado', async (req, res) => {
  try {
    const { id } = req.params;
    const { activo } = req.body;
    
    const connection = await createConnection();
    const [result] = await connection.execute(`
      UPDATE Producto SET activo = ? WHERE id_producto = ?
    `, [activo, id]);
    await connection.end();
    
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Producto no encontrado' });
    }
    
    res.json({ 
      message: `Producto ${activo ? 'activado' : 'desactivado'} correctamente` 
    });
  } catch (error) {
    console.error('Error al cambiar estado del producto:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

// Iniciar servidor
app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}`);
});

// Manejo de errores no capturados
process.on('unhandledRejection', (err) => {
  console.error('Unhandled Promise Rejection:', err);
});

process.on('uncaughtException', (err) => {
  console.error('Uncaught Exception:', err);
  process.exit(1);
});

// POST - Crear nueva venta
app.post('/api/ventas', async (req, res) => {
  const connection = await createConnection();
  
  try {
    const { items, total, metodoPago = 'efectivo' } = req.body;
    
    // Validaciones básicas
    if (!items || !Array.isArray(items) || items.length === 0) {
      return res.status(400).json({ error: 'Debe incluir items en la venta' });
    }
    
    if (!total || total <= 0) {
      return res.status(400).json({ error: 'El total debe ser mayor a 0' });
    }
    
    // Iniciar transacción
    await connection.beginTransaction();
    
    // Verificar stock disponible para todos los productos
    for (const item of items) {
      const [stockResult] = await connection.execute(
        'SELECT cantidad FROM Producto WHERE id_producto = ? AND activo = true',
        [item.productoId]
      );
      
      if (stockResult.length === 0) {
        throw new Error(`Producto con ID ${item.productoId} no encontrado o inactivo`);
      }
      
      if (stockResult[0].cantidad < item.cantidad) {
        throw new Error(`Stock insuficiente para producto ID ${item.productoId}. Stock disponible: ${stockResult[0].cantidad}`);
      }
    }
    
    // Crear la venta
    const [ventaResult] = await connection.execute(
      'INSERT INTO Venta (fecha, total, metodo_pago) VALUES (NOW(), ?, ?)',
      [total, metodoPago]
    );
    
    const ventaId = ventaResult.insertId;
    
    // Insertar detalles de venta y actualizar stock
    for (const item of items) {
      // Insertar detalle de venta
      await connection.execute(
        'INSERT INTO Detalle_Venta (id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (?, ?, ?, ?, ?)',
        [ventaId, item.productoId, item.cantidad, item.precioUnitario, item.subtotal]
      );
      
      // Actualizar stock del producto
      await connection.execute(
        'UPDATE Producto SET cantidad = cantidad - ? WHERE id_producto = ?',
        [item.cantidad, item.productoId]
      );
    }
    
    // Confirmar transacción
    await connection.commit();
    
    res.status(201).json({
      ventaId,
      message: 'Venta procesada correctamente',
      fecha: new Date().toISOString(),
      total,
      metodoPago
    });
    
  } catch (error) {
    // Revertir transacción en caso de error
    await connection.rollback();
    console.error('Error al procesar venta:', error);
    res.status(500).json({ error: error.message || 'Error interno del servidor' });
  } finally {
    await connection.end();
  }
});

// GET - Obtener todas las ventas
app.get('/api/ventas', async (req, res) => {
  try {
    const connection = await createConnection();
    const [rows] = await connection.execute(`
      SELECT 
        id_venta as id,
        fecha,
        total,
        metodo_pago as metodoPago
      FROM Venta 
      ORDER BY fecha DESC
    `);
    await connection.end();
    res.json(rows);
  } catch (error) {
    console.error('Error al obtener ventas:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

// GET - Obtener una venta con sus detalles
app.get('/api/ventas/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const connection = await createConnection();
    
    // Obtener información de la venta
    const [ventaRows] = await connection.execute(`
      SELECT 
        id_venta as id,
        fecha,
        total,
        metodo_pago as metodoPago
      FROM Venta 
      WHERE id_venta = ?
    `, [id]);
    
    if (ventaRows.length === 0) {
      await connection.end();
      return res.status(404).json({ error: 'Venta no encontrada' });
    }
    
    // Obtener detalles de la venta
    const [detalleRows] = await connection.execute(`
      SELECT 
        dv.cantidad,
        CAST(dv.precio_unitario AS DECIMAL(10,2)) as precioUnitario,
        CAST(dv.subtotal AS DECIMAL(10,2)) as subtotal,
        p.nombre as nombreProducto,
        p.unidad
      FROM Detalle_Venta dv
      JOIN Producto p ON dv.id_producto = p.id_producto
      WHERE dv.id_venta = ?
    `, [id]);
    
    await connection.end();
    
    const venta = {
      ...ventaRows[0],
      detalles: detalleRows
    };
    
    res.json(venta);
  } catch (error) {
    console.error('Error al obtener venta:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

// GET - Generar ticket de venta
app.get('/api/ventas/:id/ticket', async (req, res) => {
  try {
    const { id } = req.params;
    const connection = await createConnection();
    
    // Obtener información completa de la venta
    const [ventaRows] = await connection.execute(`
      SELECT 
        id_venta as id,
        fecha,
        total,
        metodo_pago as metodoPago
      FROM Venta 
      WHERE id_venta = ?
    `, [id]);
    
    if (ventaRows.length === 0) {
      await connection.end();
      return res.status(404).json({ error: 'Venta no encontrada' });
    }
    
    const [detalleRows] = await connection.execute(`
      SELECT 
        dv.cantidad,
        CAST(dv.precio_unitario AS DECIMAL(10,2)) as precioUnitario,
        CAST(dv.subtotal AS DECIMAL(10,2)) as subtotal,
        p.nombre as nombreProducto,
        p.unidad
      FROM Detalle_Venta dv
      JOIN Producto p ON dv.id_producto = p.id_producto
      WHERE dv.id_venta = ?
    `, [id]);
    
    await connection.end();
    
    const venta = ventaRows[0];
    const fecha = new Date(venta.fecha);
    
    // Generar ticket en formato texto
    let ticket = `
================================
        TICKET DE VENTA
================================
Fecha: ${fecha.toLocaleString('es-MX')}
Ticket No: ${venta.id}
--------------------------------

PRODUCTOS:
`;
    
    detalleRows.forEach(item => {
      // Convertir a números 
      const precioUnitario = parseFloat(item.precioUnitario) || 0;
      const subtotal = parseFloat(item.subtotal) || 0;
      
      ticket += `${item.nombreProducto}\n`;
      ticket += `  ${item.cantidad} ${item.unidad} x ${precioUnitario.toFixed(2)} = ${subtotal.toFixed(2)}\n`;
    });
    
    // Convertir total a número 
    const total = parseFloat(venta.total) || 0;
    
    ticket += `
--------------------------------
TOTAL: ${total.toFixed(2)} MXN
Método de Pago: ${venta.metodoPago.toUpperCase()}
--------------------------------
        ¡Gracias por su compra!
================================
`;
    
    res.json({
      ticket,
      venta: {
        ...venta,
        detalles: detalleRows
      }
    });
    
  } catch (error) {
    console.error('Error al generar ticket:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

// GET - Reporte de ventas por fecha
app.get('/api/ventas/reporte/:fecha', async (req, res) => {
  try {
    const { fecha } = req.params;
    const connection = await createConnection();
    
    const [rows] = await connection.execute(`
      SELECT 
        COUNT(*) as totalVentas,
        SUM(total) as totalIngresos,
        AVG(total) as promedioVenta
      FROM Venta 
      WHERE DATE(fecha) = ?
    `, [fecha]);
    
    const [ventasDetalle] = await connection.execute(`
      SELECT 
        id_venta as id,
        TIME(fecha) as hora,
        total,
        metodo_pago as metodoPago
      FROM Venta 
      WHERE DATE(fecha) = ?
      ORDER BY fecha DESC
    `, [fecha]);
    
    await connection.end();
    
    res.json({
      resumen: rows[0],
      ventas: ventasDetalle
    });
  } catch (error) {
    console.error('Error al obtener reporte:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});