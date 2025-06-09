-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-06-2025 a las 22:28:28
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tiendabd`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `Id_cliente` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `rfc` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_producto`
--

CREATE TABLE `compra_producto` (
  `Id_compra` int(11) NOT NULL,
  `Id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `Id` int(11) NOT NULL,
  `user` varchar(40) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `rfc` varchar(13) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `permiso` varchar(50) NOT NULL COMMENT '1- Vendedor\r\n2-administrador\r\n0- Bloqueado',
  `id_punto_venta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`Id`, `user`, `nombre`, `correo`, `rfc`, `apellido`, `pass`, `permiso`, `id_punto_venta`) VALUES
(2, 'sauls', 'Carlos Saul', 'oxxo@oxxo.com', '23123', 'Torres', 'password', '2', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `Id_factura` int(11) NOT NULL,
  `Id_compra` int(11) NOT NULL,
  `datos_envio` text NOT NULL,
  `Id_cliente` int(11) NOT NULL,
  `iva` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `Id_punto_venta` int(11) NOT NULL,
  `Id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `Id_producto` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`Id_producto`, `nombre`, `descripcion`, `precio`, `cantidad`) VALUES
(1, 'Leche entera 1L', 'Leche entera pasteurizada en envase de 1 litro', '25.50', 50),
(2, 'Queso panela 500g', 'Queso fresco tipo panela en presentación de 500 gramos', '65.00', 30),
(3, 'Huevo blanco 30 piezas', 'Huevo blanco grado A en cartón de 30 piezas', '75.00', 40),
(4, 'Yogur natural 1kg', 'Yogur natural sin azúcar añadida en presentación de 1 kg', '45.00', 25),
(5, 'Mantequilla sin sal 200g', 'Mantequilla sin sal en barra de 200 gramos', '38.00', 20),
(6, 'Arroz blanco 1kg', 'Arroz blanco de grano largo en paquete de 1 kilogramo', '22.00', 60),
(7, 'Frijol negro 1kg', 'Frijol negro seleccionado en paquete de 1 kilogramo', '30.00', 45),
(8, 'Lentejas 500g', 'Lentejas limpias y seleccionadas en paquete de 500 gramos', '18.50', 35),
(9, 'Avena en hojuelas 500g', 'Avena en hojuelas para cocinar en paquete de 500 gramos', '20.00', 30),
(10, 'Harina de trigo 1kg', 'Harina de trigo para todo uso en paquete de 1 kilogramo', '16.00', 40),
(11, 'Atún en agua 140g', 'Atún en trozos en agua en lata de 140 gramos', '18.00', 50),
(12, 'Sardinas en tomate 120g', 'Sardinas en salsa de tomate en lata de 120 gramos', '15.00', 40),
(13, 'Frijoles refritos 430g', 'Frijoles refritos en lata de 430 gramos', '22.00', 30),
(14, 'Chiles jalapeños en rajas 200g', 'Chiles jalapeños en rajas en lata de 200 gramos', '25.00', 25),
(15, 'Elote en grano 300g', 'Granos de elote en conserva en lata de 300 gramos', '20.00', 20),
(16, 'Aceite vegetal 1L', 'Aceite vegetal 100% puro en botella de 1 litro', '35.00', 40),
(17, 'Vinagre de manzana 500ml', 'Vinagre de manzana natural en botella de 500 ml', '28.00', 25),
(18, 'Sal yodada 1kg', 'Sal yodada fina en paquete de 1 kilogramo', '12.00', 50),
(19, 'Azúcar blanca 1kg', 'Azúcar blanca refinada en paquete de 1 kilogramo', '24.00', 45),
(20, 'Pimienta negra molida 50g', 'Pimienta negra molida en frasco de 50 gramos', '30.00', 30),
(21, 'Spaghetti 500g', 'Pasta tipo spaghetti en paquete de 500 gramos', '18.00', 40),
(22, 'Macarrones 500g', 'Pasta tipo macarrones en paquete de 500 gramos', '18.00', 35),
(23, 'Galletas saladas 200g', 'Galletas saladas tipo cracker en paquete de 200 gramos', '22.00', 50),
(24, 'Galletas de chocolate 150g', 'Galletas con chispas de chocolate en paquete de 150g', '28.00', 45),
(25, 'Pan integral 500g', 'Pan de molde integral en paquete de 500 gramos', '35.00', 30),
(26, 'Agua mineral 1L', 'Agua mineral natural en botella de 1 litro', '15.00', 80),
(27, 'Jugo de naranja 1L', 'Jugo de naranja 100% natural en tetrapack de 1L', '30.00', 40),
(28, 'Café soluble 100g', 'Café soluble en frasco de 100 gramos', '85.00', 25),
(29, 'Té negro 50 bolsitas', 'Té negro en caja con 50 bolsitas filtrantes', '45.00', 30),
(30, 'Chocolate en polvo 400g', 'Chocolate en polvo para preparar bebidas en lata de 400g', '55.00', 20),
(31, 'Leche entera 1L', 'Leche entera pasteurizada en envase de 1 litro', '25.50', 50),
(32, 'Queso panela 500g', 'Queso fresco tipo panela en presentación de 500 gramos', '65.00', 30),
(33, 'Huevo blanco 30 piezas', 'Huevo blanco grado A en cartón de 30 piezas', '75.00', 40),
(34, 'Yogur natural 1kg', 'Yogur natural sin azúcar añadida en presentación de 1 kg', '45.00', 25),
(35, 'Mantequilla sin sal 200g', 'Mantequilla sin sal en barra de 200 gramos', '38.00', 20),
(36, 'Arroz blanco 1kg', 'Arroz blanco de grano largo en paquete de 1 kilogramo', '22.00', 60),
(37, 'Frijol negro 1kg', 'Frijol negro seleccionado en paquete de 1 kilogramo', '30.00', 45),
(38, 'Lentejas 500g', 'Lentejas limpias y seleccionadas en paquete de 500 gramos', '18.50', 35),
(39, 'Avena en hojuelas 500g', 'Avena en hojuelas para cocinar en paquete de 500 gramos', '20.00', 30),
(40, 'Harina de trigo 1kg', 'Harina de trigo para todo uso en paquete de 1 kilogramo', '16.00', 40),
(41, 'Atún en agua 140g', 'Atún en trozos en agua en lata de 140 gramos', '18.00', 50),
(42, 'Sardinas en tomate 120g', 'Sardinas en salsa de tomate en lata de 120 gramos', '15.00', 40),
(43, 'Frijoles refritos 430g', 'Frijoles refritos en lata de 430 gramos', '22.00', 30),
(44, 'Chiles jalapeños en rajas 200g', 'Chiles jalapeños en rajas en lata de 200 gramos', '25.00', 25),
(45, 'Elote en grano 300g', 'Granos de elote en conserva en lata de 300 gramos', '20.00', 20),
(46, 'Aceite vegetal 1L', 'Aceite vegetal 100% puro en botella de 1 litro', '35.00', 40),
(47, 'Vinagre de manzana 500ml', 'Vinagre de manzana natural en botella de 500 ml', '28.00', 25),
(48, 'Sal yodada 1kg', 'Sal yodada fina en paquete de 1 kilogramo', '12.00', 50),
(49, 'Azúcar blanca 1kg', 'Azúcar blanca refinada en paquete de 1 kilogramo', '24.00', 45),
(50, 'Pimienta negra molida 50g', 'Pimienta negra molida en frasco de 50 gramos', '30.00', 30),
(51, 'Spaghetti 500g', 'Pasta tipo spaghetti en paquete de 500 gramos', '18.00', 40),
(52, 'Macarrones 500g', 'Pasta tipo macarrones en paquete de 500 gramos', '18.00', 35),
(53, 'Galletas saladas 200g', 'Galletas saladas tipo cracker en paquete de 200 gramos', '22.00', 50),
(54, 'Galletas de chocolate 150g', 'Galletas con chispas de chocolate en paquete de 150g', '28.00', 45),
(55, 'Pan integral 500g', 'Pan de molde integral en paquete de 500 gramos', '35.00', 30),
(56, 'Agua mineral 1L', 'Agua mineral natural en botella de 1 litro', '15.00', 80),
(57, 'Jugo de naranja 1L', 'Jugo de naranja 100% natural en tetrapack de 1L', '30.00', 40),
(58, 'Café soluble 100g', 'Café soluble en frasco de 100 gramos', '85.00', 25),
(59, 'Té negro 50 bolsitas', 'Té negro en caja con 50 bolsitas filtrantes', '45.00', 30),
(60, 'Chocolate en polvo 400g', 'Chocolate en polvo para preparar bebidas en lata de 400g', '55.00', 20),
(61, 'Leche entera 1L', 'Leche entera pasteurizada en envase de 1 litro', '25.50', 50),
(62, 'Queso panela 500g', 'Queso fresco tipo panela en presentación de 500 gramos', '65.00', 30),
(63, 'Huevo blanco 30 piezas', 'Huevo blanco grado A en cartón de 30 piezas', '75.00', 40),
(64, 'Yogur natural 1kg', 'Yogur natural sin azúcar añadida en presentación de 1 kg', '45.00', 25),
(65, 'Mantequilla sin sal 200g', 'Mantequilla sin sal en barra de 200 gramos', '38.00', 20),
(66, 'Arroz blanco 1kg', 'Arroz blanco de grano largo en paquete de 1 kilogramo', '22.00', 60),
(67, 'Frijol negro 1kg', 'Frijol negro seleccionado en paquete de 1 kilogramo', '30.00', 45),
(68, 'Lentejas 500g', 'Lentejas limpias y seleccionadas en paquete de 500 gramos', '18.50', 35),
(69, 'Avena en hojuelas 500g', 'Avena en hojuelas para cocinar en paquete de 500 gramos', '20.00', 30),
(70, 'Harina de trigo 1kg', 'Harina de trigo para todo uso en paquete de 1 kilogramo', '16.00', 40),
(71, 'Atún en agua 140g', 'Atún en trozos en agua en lata de 140 gramos', '18.00', 50),
(72, 'Sardinas en tomate 120g', 'Sardinas en salsa de tomate en lata de 120 gramos', '15.00', 40),
(73, 'Frijoles refritos 430g', 'Frijoles refritos en lata de 430 gramos', '22.00', 30),
(74, 'Chiles jalapeños en rajas 200g', 'Chiles jalapeños en rajas en lata de 200 gramos', '25.00', 25),
(75, 'Elote en grano 300g', 'Granos de elote en conserva en lata de 300 gramos', '20.00', 20),
(76, 'Aceite vegetal 1L', 'Aceite vegetal 100% puro en botella de 1 litro', '35.00', 40),
(77, 'Vinagre de manzana 500ml', 'Vinagre de manzana natural en botella de 500 ml', '28.00', 25),
(78, 'Sal yodada 1kg', 'Sal yodada fina en paquete de 1 kilogramo', '12.00', 50),
(79, 'Azúcar blanca 1kg', 'Azúcar blanca refinada en paquete de 1 kilogramo', '24.00', 45),
(80, 'Pimienta negra molida 50g', 'Pimienta negra molida en frasco de 50 gramos', '30.00', 30),
(81, 'Spaghetti 500g', 'Pasta tipo spaghetti en paquete de 500 gramos', '18.00', 40),
(82, 'Macarrones 500g', 'Pasta tipo macarrones en paquete de 500 gramos', '18.00', 35),
(83, 'Galletas saladas 200g', 'Galletas saladas tipo cracker en paquete de 200 gramos', '22.00', 50),
(84, 'Galletas de chocolate 150g', 'Galletas con chispas de chocolate en paquete de 150g', '28.00', 45),
(85, 'Pan integral 500g', 'Pan de molde integral en paquete de 500 gramos', '35.00', 30),
(86, 'Agua mineral 1L', 'Agua mineral natural en botella de 1 litro', '15.00', 80),
(87, 'Jugo de naranja 1L', 'Jugo de naranja 100% natural en tetrapack de 1L', '30.00', 40),
(88, 'Café soluble 100g', 'Café soluble en frasco de 100 gramos', '85.00', 25),
(89, 'Té negro 50 bolsitas', 'Té negro en caja con 50 bolsitas filtrantes', '45.00', 30),
(90, 'Chocolate en polvo 400g', 'Chocolate en polvo para preparar bebidas en lata de 400g', '55.00', 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `punto_venta`
--

CREATE TABLE `punto_venta` (
  `Id_punto` int(11) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `id_administrador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `punto_venta`
--

INSERT INTO `punto_venta` (`Id_punto`, `direccion`, `telefono`, `id_administrador`) VALUES
(1, 'Av. Principal 123, Col. Centro, Ciudad de México', '5551234567', 2),
(2, 'Calle Juárez 456, Zona Rosa, Guadalajara', '3339876543', 2),
(3, 'Blvd. López Mateos 789, San Pedro, Monterrey', '8187654321', 2),
(4, 'Av. Revolución 1011, Col. Moderna, Puebla', '2223456789', 2),
(5, 'Calle 60 1213, Centro, Mérida', '9998765432', 2),
(6, 'Av. Universidad 1415, Col. Del Valle, Tijuana', '6641239876', 2),
(7, 'Paseo de la Reforma 1617, Juárez, León', '4776543210', 2),
(8, 'Av. Hidalgo 1819, Centro Histórico, Querétaro', '4427890123', 2),
(9, 'Blvd. Díaz Ordaz 2021, Zona Río, Mexicali', '6862345678', 2),
(10, 'Av. Tecnológico 2223, Col. Narvarte, Veracruz', '2299012345', 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`Id_cliente`);

--
-- Indices de la tabla `compra_producto`
--
ALTER TABLE `compra_producto`
  ADD PRIMARY KEY (`Id_compra`),
  ADD KEY `Id_producto` (`Id_producto`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `user` (`user`),
  ADD KEY `id_punto_venta` (`id_punto_venta`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`Id_factura`),
  ADD KEY `Id_compra` (`Id_compra`),
  ADD KEY `Id_cliente` (`Id_cliente`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`Id_punto_venta`,`Id_producto`),
  ADD KEY `Id_producto` (`Id_producto`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`Id_producto`);

--
-- Indices de la tabla `punto_venta`
--
ALTER TABLE `punto_venta`
  ADD PRIMARY KEY (`Id_punto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `Id_cliente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `compra_producto`
--
ALTER TABLE `compra_producto`
  MODIFY `Id_compra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `Id_factura` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `Id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT de la tabla `punto_venta`
--
ALTER TABLE `punto_venta`
  MODIFY `Id_punto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compra_producto`
--
ALTER TABLE `compra_producto`
  ADD CONSTRAINT `compra_producto_ibfk_1` FOREIGN KEY (`Id_producto`) REFERENCES `producto` (`Id_producto`);

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`id_punto_venta`) REFERENCES `punto_venta` (`Id_punto`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`Id_compra`) REFERENCES `compra_producto` (`Id_compra`),
  ADD CONSTRAINT `factura_ibfk_2` FOREIGN KEY (`Id_cliente`) REFERENCES `cliente` (`Id_cliente`);

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`Id_punto_venta`) REFERENCES `punto_venta` (`Id_punto`),
  ADD CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`Id_producto`) REFERENCES `producto` (`Id_producto`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
