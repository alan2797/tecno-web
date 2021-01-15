-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-12-2019 a las 18:06:46
-- Versión del servidor: 10.3.15-MariaDB
-- Versión de PHP: 7.1.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbpanaderia`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleproducto`
--

CREATE TABLE `detalleproducto` (
  `id_detalle` int(11) NOT NULL,
  `id_insumo` int(11) NOT NULL,
  `id_produccion` int(11) NOT NULL,
  `cantidadkg` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalleproducto`
--

INSERT INTO `detalleproducto` (`id_detalle`, `id_insumo`, `id_produccion`, `cantidadkg`) VALUES
(1, 1, 1, 30),
(2, 2, 1, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleventa`
--

CREATE TABLE `detalleventa` (
  `id_detalle` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `descuento` float NOT NULL,
  `costo` float NOT NULL,
  `id_venta` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalleventa`
--

INSERT INTO `detalleventa` (`id_detalle`, `cantidad`, `descuento`, `costo`, `id_venta`, `id_producto`) VALUES
(1, 100, 12, 50, 1, 1),
(2, 300, 20, 150, 2, 3),
(3, 2000, 0, 0.3, 4, 3),
(4, 50, 0, 25, 5, 5),
(5, 2000, 0, 0.3, 6, 3),
(6, 800, 0, 0.5, 7, 1),
(7, 900, 0, 0.5, 8, 1),
(8, 500, 0, 0.3, 9, 3),
(9, 800, 0, 0.5, 9, 1),
(10, 90, 0, 25, 9, 5),
(11, 2000, 0, 0.3, 10, 3),
(12, 300, 0, 0.5, 10, 1),
(13, 2000, 20, 0.3, 11, 3),
(14, 700, 10, 0.5, 11, 1),
(15, 500, 0, 0.3, 12, 3),
(16, 200, 20, 0.5, 12, 1),
(17, 200, 0, 0.5, 13, 8),
(18, 200, 0, 0.5, 14, 8),
(19, 2001, 0, 5000, 15, 10),
(20, 2000, 0, 0.5, 16, 8),
(21, 300, 0, 0.5, 17, 8),
(22, 2015, 0, 0.5, 18, 8),
(23, 2299, 20, 5000, 19, 10),
(24, 201, 0, 0.5, 20, 8),
(25, 4000, 0, 5000, 21, 10),
(26, 209, 0, 0.5, 22, 8),
(27, 200, 0, 0.5, 23, 8),
(28, 288, 0, 1, 23, 9),
(29, 500, 0, 0.5, 24, 8),
(30, 1000, 0, 0.5, 25, 8),
(31, 200, 0, 0.5, 26, 8),
(32, 200, 0, 1, 26, 9),
(33, 200, 0, 0.5, 27, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ingreso`
--

CREATE TABLE `detalle_ingreso` (
  `id_detalle` int(11) NOT NULL,
  `precio_compra` float NOT NULL,
  `cantidad` float NOT NULL,
  `id_insumo` int(11) NOT NULL,
  `id_ingreso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalle_ingreso`
--

INSERT INTO `detalle_ingreso` (`id_detalle`, `precio_compra`, `cantidad`, `id_insumo`, `id_ingreso`) VALUES
(1, 25, 12, 1, 1),
(2, 10, 50, 2, 2),
(3, 5, 200, 1, 10),
(4, 6, 100, 2, 10),
(5, 5, 200, 1, 11),
(6, 6, 100, 2, 11),
(7, 6, 50, 1, 12);

--
-- Disparadores `detalle_ingreso`
--
DELIMITER $$
CREATE TRIGGER `tr_actualizarStock` AFTER INSERT ON `detalle_ingreso` FOR EACH ROW BEGIN
  UPDATE insumo SET Stockkg = Stockkg + NEW.cantidad
  WHERE insumo.id_insumo = NEW.id_insumo;
  END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `distribucion`
--

CREATE TABLE `distribucion` (
  `id_distribucion` int(11) NOT NULL,
  `tipo_envio` varchar(30) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `distribucion`
--

INSERT INTO `distribucion` (`id_distribucion`, `tipo_envio`, `descripcion`, `estado`) VALUES
(1, 'domicilio', 'tiempo maximo 1 hora', 'disponible'),
(2, 'dsadsadasdsa', '3 horas maxima', 'disponible');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso`
--

CREATE TABLE `ingreso` (
  `id_ingreso` int(11) NOT NULL,
  `tipo_comprobante` varchar(50) NOT NULL,
  `numero_comprobante` varchar(50) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` float NOT NULL,
  `estado` varchar(20) NOT NULL,
  `id_persona` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ingreso`
--

INSERT INTO `ingreso` (`id_ingreso`, `tipo_comprobante`, `numero_comprobante`, `fecha_hora`, `impuesto`, `estado`, `id_persona`) VALUES
(1, 'Carnet', '12695330', '2019-11-22 01:00:00', 13, 'activo', 5),
(2, 'Rut', '12695023', '2019-11-20 00:00:00', 13, 'activo', 7),
(10, 'TICKET', '2555555', '2019-12-03 14:53:07', 13, 'activo', 6),
(11, 'TICKET', '2555555', '2019-12-03 14:54:07', 13, 'activo', 6),
(12, 'BOLETA', '12555', '2019-12-10 13:20:43', 13, 'activo', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insumo`
--

CREATE TABLE `insumo` (
  `id_insumo` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `Stockkg` float NOT NULL,
  `estado` varchar(50) NOT NULL,
  `imagen` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `insumo`
--

INSERT INTO `insumo` (`id_insumo`, `nombre`, `descripcion`, `Stockkg`, `estado`, `imagen`) VALUES
(1, 'Harinaa', 'Harina de trigop', 950, 'disponible', 'imA.jpg'),
(2, 'Azucar', 'Azucar integral', 300, 'disponible', 'polera.jpg'),
(3, 'dsgsa', 'adgfads', 1000, 'no disponible', ''),
(4, 'fdsgfds', 'dfsgds', 100, 'no disponible', ''),
(5, 'xfds', 'dsfgsd', 1000, 'no disponible', ''),
(6, 'DSARD', 'DFGS', 1000, 'no disponible', ''),
(7, 'DSARD', 'DFGS', 1000, 'no disponible', ''),
(8, 'dsdg', 'dsgf', 1000, 'no disponible', ''),
(9, 'dfsafas', 'sdafa', 2000, 'no disponible', ''),
(10, 'dfgds', 'dsfg', 0, 'no disponible', ''),
(11, 'sadA', 'SADSA', 1000, 'no disponible', ''),
(12, 'SDAFDSA', 'DSAFDA', 100, 'no disponible', ''),
(13, 'DSFS', 'SDFS', 0, 'no disponible', ''),
(14, 'CXVX', 'XCVX', 7000, 'no disponible', ''),
(15, 'CZXCZX', 'ZXCZ', 400, 'no disponible', ''),
(16, 'XZCXZ', 'ZXXZ', 2100, 'no disponible', ''),
(17, 'dwad', 'weew', 2000, 'disponible', 'chalina.jpg'),
(18, 'fgh', 'dfh', 1000, 'disponible', 'blusa.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2014_10_12_000000_create_users_table', 1),
('2014_10_12_100000_create_password_resets_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `id_persona` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `tipopersona` varchar(50) NOT NULL,
  `tipodocumento` varchar(50) NOT NULL,
  `numero_documento` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`id_persona`, `nombre`, `tipopersona`, `tipodocumento`, `numero_documento`, `direccion`, `telefono`, `email`, `estado`) VALUES
(1, 'amt', 'cliente', 'llll', '4887875', 'ñññññ', '32544355', 'lklk', 'inactivo'),
(2, 'bladimir', 'cliente', 'carnet', '12695360', 'zona radial 13', '32323', 'dsad', 'activo'),
(3, 'carlos', 'cliente', 'rut', '2334', 'cLLEron', '21323', 'DSDWRE', 'activo'),
(4, 'aSAAS', 'cliente', 'ASAsasasaS', '12312', 'SADSA', 'ASDD', 'SFSDF', 'activo'),
(5, 'sdsad', 'proveedor', 'proveedor', '23323', 'dsad', '23232', 'dsad', 'inactivo'),
(6, 'saaaD', 'proveedor', 'ASda', '333333', 'dfdf', '8888888', 'dsfds', 'inactivo'),
(7, 'czfcf', 'proveedor', 'fxgd', '344343', 'fgdg', '45', 'fgddgf', 'activo'),
(8, 'sdfds', 'proveedor', 'sdfs', 'dfdsfd', 'fdgfd', '456546', 'fgdgfh', 'activo'),
(9, 'Juan thomas Rodriguez', 'empleado', 'Carnet', '12584666', 'Barrio Urbary', '789995585', 'JuanT@gmail.com', 'disponible'),
(10, 'Marcelo Amurrio', 'empleado', 'Carnet', '125846859', 'Zona los Lotes', '78552581', 'Marvelo@gmail.com', 'disponible');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `produccion`
--

CREATE TABLE `produccion` (
  `id_produccion` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `fecha_produccion` datetime NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `produccion`
--

INSERT INTO `produccion` (`id_produccion`, `id_persona`, `id_producto`, `fecha_produccion`, `cantidad`) VALUES
(1, 9, 1, '2019-12-05 00:00:00', 4000),
(2, 10, 2, '2019-12-25 00:00:00', 2000),
(3, 9, 1, '2019-12-10 06:37:32', 2000),
(4, 9, 1, '2019-12-10 06:38:31', 2000),
(5, 9, 3, '2019-12-10 06:40:42', 4000),
(6, 9, 1, '2019-12-10 10:10:21', 2520),
(7, 10, 3, '2019-12-10 11:49:10', 3000),
(8, 9, 1, '2019-12-10 12:00:51', 2500),
(9, 10, 3, '2019-12-10 12:03:33', 2003),
(10, 9, 1, '2019-12-10 12:06:37', 2300),
(11, 9, 1, '2019-12-10 12:31:07', 2000),
(12, 9, 1, '2019-12-10 12:31:47', 2500),
(13, 9, 1, '2019-12-10 12:50:15', 452),
(14, 9, 1, '2019-12-10 12:50:37', 2020),
(15, 9, 1, '2019-12-10 12:51:37', 5000),
(16, 10, 3, '2019-12-10 13:15:31', 3000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `stock` int(11) NOT NULL,
  `preciounidad` float NOT NULL,
  `estado` varchar(20) NOT NULL,
  `imagen` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `nombre`, `stock`, `preciounidad`, `estado`, `imagen`) VALUES
(1, 'pan cavero', 1000, 0.5, 'agotado', NULL),
(2, 'pan DE trigo', 2000, 0.6, 'agotado', NULL),
(3, 'pan rosca', 3000, 0.3, 'agotado', NULL),
(4, 'dgfd', 2555, 21, 'agotado', NULL),
(5, 'sadasad', 100, 25, 'agotado', 'imA.jpg'),
(6, 'pan Mollete', 5000, 0.5, 'agotado', 'btp22.jpg'),
(7, 'Pan de Integral', 5000, 0.5, 'disponoble', 'integral.jpg'),
(8, 'Pan de Maiz', 5000, 0.5, 'disponoble', 'maiz.jpg'),
(9, 'Pan Mollete', 5000, 1, 'disponoble', 'mollete.jfif'),
(10, 'Pan Rosca', 5000, 5000, 'disponoble', 'rosca.jpg'),
(11, 'Pan De Trigo', 3000, 0.5, 'disponoble', 'trigo.jpg'),
(12, 'Pan Blanco', 2000, 0.5, 'disponoble', 'blanco.jpg'),
(14, 'pan de arroz', 8000, 0.6, 'disponoble', 'Arroz.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transporte`
--

CREATE TABLE `transporte` (
  `id_transporte` int(11) NOT NULL,
  `placa` varchar(20) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `color` varchar(20) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `transporte`
--

INSERT INTO `transporte` (`id_transporte`, `placa`, `modelo`, `color`, `descripcion`, `estado`) VALUES
(1, '678-BTP', 'NISSAN COROLLA 2011', 'ROJO', 'temporal', 'inactivo'),
(2, '258-MCN', 'Motocicleta Ninja 2015', 'verde', 'prestado', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'bladimir', 'admin@gmail.com', '$2y$10$YF5N71XXjOhvzA4/5c9w4ek3OZ4j7Euoa01/OuLsUiduP888Gab3m', NULL, '2019-11-08 13:46:32', '2019-11-08 13:46:32');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `id_venta` int(11) NOT NULL,
  `tipo_comprobante` varchar(50) NOT NULL,
  `num_comprobante` double NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` float NOT NULL,
  `total_venta` float NOT NULL,
  `estado` varchar(20) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `id_distribucion` int(11) DEFAULT NULL,
  `id_transporte` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`id_venta`, `tipo_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total_venta`, `estado`, `id_persona`, `id_distribucion`, `id_transporte`) VALUES
(1, 'boleta', 12587899, '2019-12-18 00:00:00', 13, 500, 'inactivo', 2, 2, 2),
(2, 'factura', 125487888, '2019-12-25 00:00:00', 13, 200, 'Pendiente', 3, 2, 2),
(4, 'BOLETA', 555555, '2019-12-08 07:07:17', 13, 600, 'Entregando', 1, 2, 1),
(5, 'TICKET', 21212121, '2019-12-08 07:09:38', 13, 1250, 'activo', 1, 2, 2),
(6, 'FACTURA', 12555, '2019-12-08 07:12:06', 13, 600, 'activo', 1, 2, 2),
(7, 'BOLETA', 111111111, '2019-12-08 07:13:49', 13, 400, 'activo', 2, 2, 2),
(8, 'BOLETA', 3020000, '2019-12-08 07:26:52', 13, 450, 'activo', 4, 2, 2),
(9, 'TICKET', 2588888, '2019-12-08 07:30:37', 13, 2790, 'activo', 1, 2, 2),
(10, 'FACTURA', 2588888, '2019-12-09 15:36:40', 13, 720, 'activo', 2, 2, 2),
(11, 'TICKET', 121444444, '2019-12-09 15:53:19', 13, 920, 'activo', 1, 2, 2),
(12, 'FACTURA', 124545455, '2019-12-10 22:20:15', 13, 230, 'activo', 2, 2, 2),
(13, 'BOLETA', 2555555, '2019-12-12 21:32:50', 13, 100, 'activo', 1, 1, 2),
(14, 'FACTURA', 255888, '2019-12-14 19:16:06', 13, 100, 'activo', 2, 1, 2),
(15, 'BOLETA', 445555, '2019-12-14 20:40:16', 13, 10005000, 'activo', 1, 1, 2),
(16, 'BOLETA', 454545454, '2019-12-14 20:58:50', 13, 1000, 'activo', 2, 1, 2),
(17, 'BOLETA', 11111111, '2019-12-14 21:07:57', 13, 150, 'inactivo', 2, 1, 2),
(18, 'BOLETA', 212121212, '2019-12-15 09:26:24', 13, 1007.5, 'activo', 1, 1, 2),
(19, 'BOLETA', 25555, '2019-12-15 09:50:31', 13, 11495000, 'activo', 3, 1, 2),
(20, 'BOLETA', 454545455, '2019-12-15 10:36:50', 13, 100.5, 'activo', 2, 1, 2),
(21, 'TICKET', 454545456, '2019-12-15 10:39:24', 13, 20000000, 'activo', 2, 1, 2),
(22, 'FACTURA', 454545457, '2019-12-17 05:06:56', 13, 104.5, 'Enviado', 3, 1, 1),
(23, 'FACTURA', 454545458, '2019-12-17 07:02:39', 13, 388, 'Pendiente', 1, 1, 2),
(24, 'BOLETA', 454545459, '2019-12-17 09:47:03', 13, 250, 'Pendiente', 3, 1, 2),
(25, 'FACTURA', 454545460, '2019-12-17 10:09:23', 13, 500, 'Pendiente', 2, 1, 2),
(26, 'TICKET', 454545461, '2019-12-17 10:22:04', 13, 300, 'Pendiente', 2, 1, 2),
(27, 'FACTURA', 454545462, '2019-12-17 11:46:54', 13, 100, 'Pendiente', 2, 1, 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `detalleproducto`
--
ALTER TABLE `detalleproducto`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_insumo` (`id_insumo`),
  ADD KEY `id_detalleproducto` (`id_produccion`);

--
-- Indices de la tabla `detalleventa`
--
ALTER TABLE `detalleventa`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_venta` (`id_venta`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_insumo` (`id_insumo`),
  ADD KEY `id_ingreso` (`id_ingreso`);

--
-- Indices de la tabla `distribucion`
--
ALTER TABLE `distribucion`
  ADD PRIMARY KEY (`id_distribucion`);

--
-- Indices de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`id_ingreso`),
  ADD KEY `id_persona` (`id_persona`);

--
-- Indices de la tabla `insumo`
--
ALTER TABLE `insumo`
  ADD PRIMARY KEY (`id_insumo`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`id_persona`);

--
-- Indices de la tabla `produccion`
--
ALTER TABLE `produccion`
  ADD PRIMARY KEY (`id_produccion`),
  ADD KEY `id_persona` (`id_persona`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `transporte`
--
ALTER TABLE `transporte`
  ADD PRIMARY KEY (`id_transporte`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `id_persona` (`id_persona`),
  ADD KEY `id_distribucion` (`id_distribucion`),
  ADD KEY `id_transporte` (`id_transporte`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `detalleproducto`
--
ALTER TABLE `detalleproducto`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `detalleventa`
--
ALTER TABLE `detalleventa`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `distribucion`
--
ALTER TABLE `distribucion`
  MODIFY `id_distribucion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `id_ingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `insumo`
--
ALTER TABLE `insumo`
  MODIFY `id_insumo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `id_persona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `produccion`
--
ALTER TABLE `produccion`
  MODIFY `id_produccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `transporte`
--
ALTER TABLE `transporte`
  MODIFY `id_transporte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalleproducto`
--
ALTER TABLE `detalleproducto`
  ADD CONSTRAINT `detalleproducto_ibfk_1` FOREIGN KEY (`id_insumo`) REFERENCES `insumo` (`id_insumo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalleproducto_ibfk_2` FOREIGN KEY (`id_produccion`) REFERENCES `produccion` (`id_produccion`);

--
-- Filtros para la tabla `detalleventa`
--
ALTER TABLE `detalleventa`
  ADD CONSTRAINT `detalleventa_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalleventa_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD CONSTRAINT `detalle_ingreso_ibfk_1` FOREIGN KEY (`id_insumo`) REFERENCES `insumo` (`id_insumo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_ingreso_ibfk_2` FOREIGN KEY (`id_ingreso`) REFERENCES `ingreso` (`id_ingreso`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD CONSTRAINT `ingreso_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `produccion`
--
ALTER TABLE `produccion`
  ADD CONSTRAINT `produccion_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`),
  ADD CONSTRAINT `produccion_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`id_distribucion`) REFERENCES `distribucion` (`id_distribucion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `venta_ibfk_3` FOREIGN KEY (`id_transporte`) REFERENCES `transporte` (`id_transporte`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
