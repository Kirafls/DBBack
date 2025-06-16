-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-06-2025 a las 16:37:21
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
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `id_detalle` int(11) NOT NULL,
  `id_venta` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`id_detalle`, `id_venta`, `id_producto`, `cantidad`, `precio_unitario`, `subtotal`) VALUES
(1, 1, 16, 3, '35.00', '105.00'),
(2, 2, 4, 4, '45.00', '180.00'),
(3, 3, 16, 4, '35.00', '140.00'),
(4, 4, 86, 2, '15.00', '30.00'),
(5, 4, 56, 2, '15.00', '30.00'),
(6, 4, 26, 2, '15.00', '30.00'),
(7, 4, 76, 2, '35.00', '70.00'),
(8, 5, 46, 2, '35.00', '70.00'),
(9, 5, 76, 2, '35.00', '70.00'),
(10, 6, 2, 5, '65.00', '325.00'),
(11, 7, 16, 3, '35.00', '105.00'),
(12, 8, 16, 3, '35.00', '105.00'),
(13, 8, 46, 3, '35.00', '105.00'),
(14, 8, 26, 3, '15.00', '45.00'),
(15, 8, 56, 3, '15.00', '45.00'),
(16, 9, 26, 4, '15.00', '60.00'),
(17, 10, 41, 1, '18.00', '18.00'),
(18, 10, 11, 1, '18.00', '18.00'),
(19, 10, 9, 1, '20.00', '20.00'),
(20, 10, 39, 1, '20.00', '20.00'),
(21, 10, 2, 2, '65.00', '130.00'),
(22, 10, 1, 1, '25.50', '25.50'),
(23, 10, 49, 1, '24.00', '24.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `Id` int(11) NOT NULL,
  `user` varchar(40) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `permiso` varchar(50) NOT NULL COMMENT '1- Vendedor\r\n2-administrador\r\n0- Bloqueado',
  `id_punto_venta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`Id`, `user`, `nombre`, `apellido`, `pass`, `permiso`, `id_punto_venta`) VALUES
(2, 'sauls', 'Carlos34', 'Torres', 'password', '2', 1),
(3, 'dsd', 'Lopez', 'Carlos', 'flath', '0', 1),
(4, '34sds', 'Carlos44', 'Torres', 'flath', '1', 1),
(5, 'fls', 'Carlos', 'Torres', 'flath', '2', 1),
(6, 'saul', 'Mario', 'Lopez', '12345', '1', 1),
(7, 'sauls2', 'Erick', 'Torres', 'flath', '1', 1);

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
  `total` decimal(10,2) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `metodo_pago` varchar(50) DEFAULT 'Efectivo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`Id_factura`, `Id_compra`, `datos_envio`, `Id_cliente`, `iva`, `total`, `fecha`, `metodo_pago`) VALUES
(8, 1010101010, 'Envío estándar a domicilio', 1, '32.00', '400.00', '2025-06-15 17:06:48', 'Tarjeta'),
(10, 1010101010, 'Envío estándar a domicilio', 1, '32.00', '400.00', '2025-06-15 18:10:17', 'Tarjeta'),
(11, 1010101013, 'Retiro en sucursal', 1, '45.00', '500.00', '2025-06-15 18:10:17', 'Efectivo'),
(12, 1010101016, 'Domicilio Express', 1, '60.00', '670.00', '2025-06-15 18:10:17', 'Transferencia'),
(13, 1010101017, 'Zona Norte - Domicilio', 1, '25.00', '280.00', '2025-06-15 18:10:17', 'Tarjeta'),
(14, 1010101018, 'Entrega programada', 1, '30.00', '330.00', '2025-06-15 18:10:17', 'Efectivo'),
(15, 1010101019, 'Sucursal central', 1, '40.00', '450.00', '2025-06-15 18:10:17', 'Transferencia');

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
  `cantidad` int(11) NOT NULL,
  `unidad` varchar(10) NOT NULL,
  `categoria` varchar(100) NOT NULL,
  `activo` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`Id_producto`, `nombre`, `descripcion`, `precio`, `cantidad`, `unidad`, `categoria`, `activo`) VALUES
(1, 'Leche entera 1L', 'Leche entera pasteurizada en envase de 1 litro', '25.50', 49, '', '', 1),
(2, 'Queso panela 500g', 'Queso fresco tipo panela en presentación de 500 gramos', '65.00', 23, '', '', 1),
(3, 'Huevo blanco 30 piezas', 'Huevo blanco grado A en cartón de 30 piezas', '75.00', 40, '', '', 0),
(4, 'Yogur natural 1kg', 'Yogur natural sin azúcar añadida en presentación de 1 kg', '45.00', 0, 'KG', '', 1),
(5, 'Mantequilla sin sal 200g', 'Mantequilla sin sal en barra de 200 gramos', '38.00', 20, '', '', 0),
(6, 'Arroz blanco 1kg', 'Arroz blanco de grano largo en paquete de 1 kilogramo', '22.00', 60, '', '', 1),
(7, 'Frijol negro 1kg', 'Frijol negro seleccionado en paquete de 1 kilogramo', '30.00', 45, '', '', 0),
(8, 'Lentejas 500g', 'Lentejas limpias y seleccionadas en paquete de 500 gramos', '18.50', 35, '', '', 0),
(9, 'Avena en hojuelas 500g', 'Avena en hojuelas para cocinar en paquete de 500 gramos', '20.00', 29, '', '', 1),
(10, 'Harina de trigo 1kg', 'Harina de trigo para todo uso en paquete de 1 kilogramo', '16.00', 40, '', '', 0),
(11, 'Atún en agua 140g', 'Atún en trozos en agua en lata de 140 gramos', '18.00', 49, '', '', 1),
(12, 'Sardinas en tomate 120g', 'Sardinas en salsa de tomate en lata de 120 gramos', '15.00', 40, '', '', 0),
(13, 'Frijoles refritos 430g', 'Frijoles refritos en lata de 430 gramos', '22.00', 30, '', '', 0),
(14, 'Chiles jalapeños en rajas 200g', 'Chiles jalapeños en rajas en lata de 200 gramos', '25.00', 25, '', '', 0),
(15, 'Elote en grano 300g', 'Granos de elote en conserva en lata de 300 gramos', '20.00', 20, '', '', 0),
(16, 'Aceite vegetal 1L', 'Aceite vegetal 100% puro en botella de 1 litro', '35.00', 27, '', '', 1),
(17, 'Vinagre de manzana 500ml', 'Vinagre de manzana natural en botella de 500 ml', '28.00', 25, '', '', 0),
(18, 'Sal yodada 1kg', 'Sal yodada fina en paquete de 1 kilogramo', '12.00', 50, '', '', 0),
(19, 'Azúcar blanca 1kg', 'Azúcar blanca refinada en paquete de 1 kilogramo', '24.00', 45, '', '', 1),
(20, 'Pimienta negra molida 50g', 'Pimienta negra molida en frasco de 50 gramos', '30.00', 30, '', '', 0),
(21, 'Spaghetti 500g', 'Pasta tipo spaghetti en paquete de 500 gramos', '18.00', 40, '', '', 0),
(22, 'Macarrones 500g', 'Pasta tipo macarrones en paquete de 500 gramos', '18.00', 35, '', '', 0),
(23, 'Galletas saladas 200g', 'Galletas saladas tipo cracker en paquete de 200 gramos', '22.00', 50, '', '', 0),
(24, 'Galletas de chocolate 150g', 'Galletas con chispas de chocolate en paquete de 150g', '28.00', 45, '', '', 0),
(25, 'Pan integral 500g', 'Pan de molde integral en paquete de 500 gramos', '35.00', 30, '', '', 0),
(26, 'Agua mineral 1L', 'Agua mineral natural en botella de 1 litro', '15.00', 71, '', '', 1),
(27, 'Jugo de naranja 1L', 'Jugo de naranja 100% natural en tetrapack de 1L', '30.00', 40, '', '', 0),
(28, 'Café soluble 100g', 'Café soluble en frasco de 100 gramos', '85.00', 25, '', '', 0),
(29, 'Té negro 50 bolsitas', 'Té negro en caja con 50 bolsitas filtrantes', '45.00', 30, '', '', 0),
(30, 'Chocolate en polvo 400g', 'Chocolate en polvo para preparar bebidas en lata de 400g', '55.00', 20, '', '', 0),
(31, 'Leche entera 1L', 'Leche entera pasteurizada en envase de 1 litro', '25.50', 50, '', '', 0),
(32, 'Queso panela 500g', 'Queso fresco tipo panela en presentación de 500 gramos', '65.00', 30, '', '', 0),
(33, 'Huevo blanco 30 piezas', 'Huevo blanco grado A en cartón de 30 piezas', '75.00', 40, '', '', 0),
(34, 'Yogur natural 1kg', 'Yogur natural sin azúcar añadida en presentación de 1 kg', '45.00', 25, '', '', 0),
(35, 'Mantequilla sin sal 200g', 'Mantequilla sin sal en barra de 200 gramos', '38.00', 20, '', '', 0),
(36, 'Arroz blanco 1kg', 'Arroz blanco de grano largo en paquete de 1 kilogramo', '22.00', 60, '', '', 1),
(37, 'Frijol negro 1kg', 'Frijol negro seleccionado en paquete de 1 kilogramo', '30.00', 45, '', '', 0),
(38, 'Lentejas 500g', 'Lentejas limpias y seleccionadas en paquete de 500 gramos', '18.50', 35, '', '', 0),
(39, 'Avena en hojuelas 500g', 'Avena en hojuelas para cocinar en paquete de 500 gramos', '20.00', 29, '', '', 1),
(40, 'Harina de trigo 1kg', 'Harina de trigo para todo uso en paquete de 1 kilogramo', '16.00', 40, '', '', 0),
(41, 'Atún en agua 140g', 'Atún en trozos en agua en lata de 140 gramos', '18.00', 49, '', '', 1),
(42, 'Sardinas en tomate 120g', 'Sardinas en salsa de tomate en lata de 120 gramos', '15.00', 40, '', '', 0),
(43, 'Frijoles refritos 430g', 'Frijoles refritos en lata de 430 gramos', '22.00', 30, '', '', 0),
(44, 'Chiles jalapeños en rajas 200g', 'Chiles jalapeños en rajas en lata de 200 gramos', '25.00', 25, '', '', 0),
(45, 'Elote en grano 300g', 'Granos de elote en conserva en lata de 300 gramos', '20.00', 20, '', '', 0),
(46, 'Aceite vegetal 1L', 'Aceite vegetal 100% puro en botella de 1 litro', '35.00', 35, '', '', 1),
(47, 'Vinagre de manzana 500ml', 'Vinagre de manzana natural en botella de 500 ml', '28.00', 25, '', '', 0),
(48, 'Sal yodada 1kg', 'Sal yodada fina en paquete de 1 kilogramo', '12.00', 50, '', '', 0),
(49, 'Azúcar blanca 1kg', 'Azúcar blanca refinada en paquete de 1 kilogramo', '24.00', 44, '', '', 1),
(50, 'Pimienta negra molida 50g', 'Pimienta negra molida en frasco de 50 gramos', '30.00', 30, '', '', 0),
(51, 'Spaghetti 500g', 'Pasta tipo spaghetti en paquete de 500 gramos', '18.00', 40, '', '', 0),
(52, 'Macarrones 500g', 'Pasta tipo macarrones en paquete de 500 gramos', '18.00', 35, '', '', 0),
(53, 'Galletas saladas 200g', 'Galletas saladas tipo cracker en paquete de 200 gramos', '22.00', 50, '', '', 0),
(54, 'Galletas de chocolate 150g', 'Galletas con chispas de chocolate en paquete de 150g', '28.00', 45, '', '', 0),
(55, 'Pan integral 500g', 'Pan de molde integral en paquete de 500 gramos', '35.00', 30, '', '', 0),
(56, 'Agua mineral 1L', 'Agua mineral natural en botella de 1 litro', '15.00', 75, '', '', 1),
(57, 'Jugo de naranja 1L', 'Jugo de naranja 100% natural en tetrapack de 1L', '30.00', 40, '', '', 0),
(58, 'Café soluble 100g', 'Café soluble en frasco de 100 gramos', '85.00', 25, '', '', 0),
(59, 'Té negro 50 bolsitas', 'Té negro en caja con 50 bolsitas filtrantes', '45.00', 30, '', '', 0),
(60, 'Chocolate en polvo 400g', 'Chocolate en polvo para preparar bebidas en lata de 400g', '55.00', 20, '', '', 0),
(61, 'Leche entera 1L', 'Leche entera pasteurizada en envase de 1 litro', '25.50', 50, '', '', 0),
(62, 'Queso panela 500g', 'Queso fresco tipo panela en presentación de 500 gramos', '65.00', 30, '', '', 0),
(63, 'Huevo blanco 30 piezas', 'Huevo blanco grado A en cartón de 30 piezas', '75.00', 40, '', '', 0),
(64, 'Yogur natural 1kg', 'Yogur natural sin azúcar añadida en presentación de 1 kg', '45.00', 25, '', '', 0),
(65, 'Mantequilla sin sal 200g', 'Mantequilla sin sal en barra de 200 gramos', '38.00', 20, '', '', 0),
(66, 'Arroz blanco 1kg', 'Arroz blanco de grano largo en paquete de 1 kilogramo', '22.00', 60, '', '', 1),
(67, 'Frijol negro 1kg', 'Frijol negro seleccionado en paquete de 1 kilogramo', '30.00', 45, '', '', 0),
(68, 'Lentejas 500g', 'Lentejas limpias y seleccionadas en paquete de 500 gramos', '18.50', 35, '', '', 0),
(69, 'Avena en hojuelas 500g', 'Avena en hojuelas para cocinar en paquete de 500 gramos', '20.00', 30, '', '', 1),
(70, 'Harina de trigo 1kg', 'Harina de trigo para todo uso en paquete de 1 kilogramo', '16.00', 40, '', '', 0),
(71, 'Atún en agua 140g', 'Atún en trozos en agua en lata de 140 gramos', '18.00', 50, '', '', 1),
(72, 'Sardinas en tomate 120g', 'Sardinas en salsa de tomate en lata de 120 gramos', '15.00', 40, '', '', 0),
(73, 'Frijoles refritos 430g', 'Frijoles refritos en lata de 430 gramos', '22.00', 30, '', '', 0),
(74, 'Chiles jalapeños en rajas 200g', 'Chiles jalapeños en rajas en lata de 200 gramos', '25.00', 25, '', '', 0),
(75, 'Elote en grano 300g', 'Granos de elote en conserva en lata de 300 gramos', '20.00', 20, '', '', 0),
(76, 'Aceite vegetal 1L', 'Aceite vegetal 100% puro en botella de 1 litro', '35.00', 36, '', '', 1),
(77, 'Vinagre de manzana 500ml', 'Vinagre de manzana natural en botella de 500 ml', '28.00', 25, '', '', 0),
(78, 'Sal yodada 1kg', 'Sal yodada fina en paquete de 1 kilogramo', '12.00', 50, '', '', 0),
(79, 'Azúcar blanca 1kg', 'Azúcar blanca refinada en paquete de 1 kilogramo', '24.00', 45, '', '', 1),
(80, 'Pimienta negra molida 50g', 'Pimienta negra molida en frasco de 50 gramos', '30.00', 30, '', '', 0),
(81, 'Spaghetti 500g', 'Pasta tipo spaghetti en paquete de 500 gramos', '18.00', 40, '', '', 0),
(82, 'Macarrones 500g', 'Pasta tipo macarrones en paquete de 500 gramos', '18.00', 35, '', '', 0),
(83, 'Galletas saladas 200g', 'Galletas saladas tipo cracker en paquete de 200 gramos', '22.00', 50, '', '', 0),
(84, 'Galletas de chocolate 150g', 'Galletas con chispas de chocolate en paquete de 150g', '28.00', 45, '', '', 0),
(85, 'Pan integral 500g', 'Pan de molde integral en paquete de 500 gramos', '35.00', 30, '', '', 0),
(86, 'Agua mineral 1L', 'Agua mineral natural en botella de 1 litro', '15.00', 78, '', '', 1),
(87, 'Jugo de naranja 1L', 'Jugo de naranja 100% natural en tetrapack de 1L', '30.00', 40, '', '', 0),
(88, 'Café soluble 100g', 'Café soluble en frasco de 100 gramos', '85.00', 25, '', '', 0),
(89, 'Té negro 50 bolsitas', 'Té negro en caja con 50 bolsitas filtrantes', '45.00', 30, '', '', 0),
(90, 'Chocolate en polvo 400g', 'Chocolate en polvo para preparar bebidas en lata de 400g', '55.00', 20, '', '', 0);

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `id_venta` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL,
  `metodo_pago` varchar(50) NOT NULL DEFAULT 'efectivo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`id_venta`, `fecha`, `total`, `metodo_pago`) VALUES
(1, '2025-06-13 22:27:35', '105.00', 'efectivo'),
(2, '2025-06-13 22:31:41', '180.00', 'efectivo'),
(3, '2025-06-13 22:32:23', '140.00', 'efectivo'),
(4, '2025-06-13 22:33:20', '160.00', 'efectivo'),
(5, '2025-06-13 22:37:03', '140.00', 'efectivo'),
(6, '2025-06-13 22:43:39', '325.00', 'efectivo'),
(7, '2025-06-16 02:39:25', '105.00', 'efectivo'),
(8, '2025-06-16 08:24:56', '300.00', 'efectivo'),
(9, '2025-06-16 08:26:46', '60.00', 'efectivo'),
(10, '2025-06-16 08:27:22', '255.50', 'efectivo');

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
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `idx_venta` (`id_venta`),
  ADD KEY `idx_producto` (`id_producto`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `user` (`user`),
  ADD KEY `id_punto_venta` (`id_punto_venta`);

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
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `idx_fecha` (`fecha`),
  ADD KEY `idx_total` (`total`);

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
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compra_producto`
--
ALTER TABLE `compra_producto`
  ADD CONSTRAINT `compra_producto_ibfk_1` FOREIGN KEY (`Id_producto`) REFERENCES `producto` (`Id_producto`);

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`Id_producto`);

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`id_punto_venta`) REFERENCES `punto_venta` (`Id_punto`);

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
