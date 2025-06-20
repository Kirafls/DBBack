const { query } = require("express");
const mysql =require("mysql");

function buscarUser(connection, data, callback) {
    // Determinar si estamos buscando por ID o por nombre de usuario
    const isIdSearch = data.hasOwnProperty('id');
    const searchValue = isIdSearch ? data.id : data.user;
    
    // Construir la consulta dinámicamente
    let select = "SELECT `Id`, `pass`, `user`, `permiso` FROM empleado WHERE ";
    select += isIdSearch ? "`Id` = ?" : "`user` = ?";
    
    // Formatear la consulta SQL
    let query = mysql.format(select, [searchValue]);
    
    // Ejecutar la consulta
    connection.query(query, function (err, result) {
        if (err) {
            console.error("Error en la consulta MySQL:", err);
            // En lugar de lanzar el error, lo pasamos al callback
            return callback(null, err);
        }
        callback(null, result); // Convención Node.js: error primero
    });
}

module.exports={buscarUser};//Se tienen que exportar cada una de las funciones