const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const mysql=require('mysql');
const path = require('path');
require('dotenv').config();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
//declaracion de las funciuones de mysql
const {buscarUser}=require('./consultas');
const app = express();
const PORT = process.env.PORT || 3000;
const SECRET_KEY = 'clave_secreta';

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Servir los archivos estáticos de Angular
app.use(express.static(path.join(__dirname, 'dist/front-end')));

// Rutas de la aplicación
app.get('/*', (req, res) => {
  res.send("Hola desde el Back");
});



//conexion a la base de datos
const connection =mysql.createConnection({
  host:"localhost",
  user:"root",
  password:"",
  database:"tiendabd",//Nombre de la base de datos
});

// Versión modificada del endpoint que usa la nueva buscarUser
app.post('/tienda/login', (req, res) => {
  console.log("Solicitud de Front");
  const { username, password, id } = req.body;

  // Validación básica
  if ((!username && !id) || !password) {
    return res.status(400).json({ message: 'Se requiere (username o id) y password' });
  }

  // Determinar criterio de búsqueda
  const searchCriteria = username ? { user: username } : { id: id };

  buscarUser(connection, searchCriteria, (err, result) => {
    if (err) {
      console.error('Error en búsqueda de usuario:', err);
      return res.status(500).json({ message: 'Error interno del servidor' });
    }

    if (result.length === 0) {
      return res.status(401).json({ message: 'Credenciales inválidas' });
    }

    const user = result[0];
    
    // Comparación de contraseña (mejor usar bcrypt en producción)
    if (password !== user.pass) {
      return res.status(401).json({ message: 'Credenciales inválidas' });
    }

    // Crear token
    const token = jwt.sign({ 
      id: user.Id,  // Nota: aquí es Id (mayúscula) según tu consulta SQL
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
  });
});

app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
