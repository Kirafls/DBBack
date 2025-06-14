// server.js o app.js
const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');

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

// PATCH - Cambiar estado del producto (activo/inactivo)
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