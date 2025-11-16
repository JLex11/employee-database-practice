-- =====================================================
-- EXPORTACIÓN COMPLETA DE BASE DE DATOS
-- Database: empresa_rrhh
-- Fecha de exportación: 2025-11-16 15:30:45
-- Servidor: MySQL 8.0.35
-- Usuario: admin_rrhh
-- =====================================================
--
-- INSTRUCCIONES:
-- Este archivo contiene TODO lo necesario.
-- Solo ejecuta: mysql -u root -p < empresa_rrhh_export_completo.sql
--
-- =====================================================

-- Configuración de variables de sesión
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- PASO 1: Crear usuario de aplicación
--

-- Crear usuario admin_rrhh si no existe
CREATE USER IF NOT EXISTS 'admin_rrhh'@'localhost' IDENTIFIED BY 'Rrhh2024$ecure';
CREATE USER IF NOT EXISTS 'admin_rrhh'@'%' IDENTIFIED BY 'Rrhh2024$ecure';

--
-- PASO 2: Crear la base de datos
--

CREATE DATABASE IF NOT EXISTS `empresa_rrhh`
  /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */
  /*!80016 DEFAULT ENCRYPTION='N' */;

USE `empresa_rrhh`;

--
-- PASO 3: Otorgar permisos al usuario
--

GRANT ALL PRIVILEGES ON `empresa_rrhh`.* TO 'admin_rrhh'@'localhost';
GRANT ALL PRIVILEGES ON `empresa_rrhh`.* TO 'admin_rrhh'@'%';
FLUSH PRIVILEGES;

--
-- PASO 4: Estructura de tabla para `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `idempleado` int NOT NULL,
  `apellido` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`idempleado`),
  UNIQUE KEY `uk_email` (`email`),
  KEY `idx_apellido` (`apellido`),
  KEY `idx_nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de empleados de la empresa';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- PASO 5: Volcado de datos para la tabla `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES
(111,'Vélez','Jaime','Cra 1 #1-1','vj@gmail.com'),
(222,'Roldan','Eliecer','Cra 2 #1-1','re@gmail.com'),
(333,'Perez','Diego','Cra 3 #1-1','pd@gmail.com'),
(444,'Ochoa','Leo','Cra 5 #1-1','ol@gmail.com'),
(555,'Roa','Ana','Cra 6 #1-1','ra@gmail.com');
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- PASO 6: Triggers (si existieran - este ejemplo no tiene)
--

--
-- PASO 7: Stored Procedures (si existieran - este ejemplo no tiene)
--

--
-- PASO 8: Views (si existieran - este ejemplo no tiene)
--

--
-- PASO 9: Events (si existieran - este ejemplo no tiene)
--

-- Restaurar configuración de variables de sesión
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- =====================================================
-- VERIFICACIÓN: Mostrar datos insertados
-- =====================================================

SELECT '========================================' as '';
SELECT 'IMPORTACIÓN COMPLETADA EXITOSAMENTE' as 'ESTADO';
SELECT '========================================' as '';
SELECT '' as '';

SELECT 'Base de datos:' as 'Información', 'empresa_rrhh' as 'Valor'
UNION ALL
SELECT 'Usuario:', 'admin_rrhh'
UNION ALL
SELECT 'Contraseña:', 'Rrhh2024$ecure'
UNION ALL
SELECT 'Host:', 'localhost'
UNION ALL
SELECT 'Puerto:', '3306';

SELECT '' as '';
SELECT '========================================' as '';
SELECT 'DATOS IMPORTADOS' as '';
SELECT '========================================' as '';

SELECT
  idempleado as 'ID',
  nombre as 'Nombre',
  apellido as 'Apellido',
  email as 'Email',
  direccion as 'Dirección'
FROM empleados
ORDER BY idempleado;

SELECT '' as '';
SELECT CONCAT('Total de empleados: ', COUNT(*)) as 'Resumen'
FROM empleados;

SELECT '' as '';
SELECT '========================================' as '';
SELECT 'CONFIGURACIÓN DE .env' as '';
SELECT '========================================' as '';
SELECT 'Copia estos valores en tu archivo .env:' as '';
SELECT '' as '';
SELECT 'DB_HOST=localhost' as '';
SELECT 'DB_PORT=3306' as '';
SELECT 'DB_NAME=empresa_rrhh' as '';
SELECT 'DB_USER=admin_rrhh' as '';
SELECT 'DB_PASSWORD=Rrhh2024$ecure' as '';
SELECT '' as '';
SELECT '¡Listo para usar!' as '';

-- Dump completado el 2025-11-16 15:30:45
