-- ============================================
-- Script de creación e inicialización
-- Base de datos: empresa_rrhh
-- Motor: MySQL/InnoDB
-- Versión: 8.0+
-- ============================================

-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS empresa_rrhh
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- Seleccionar la base de datos
USE empresa_rrhh;

-- Eliminar la tabla si existe (para re-creación)
DROP TABLE IF EXISTS empleados;

-- Crear tabla empleados
CREATE TABLE empleados (
  idempleado INT NOT NULL AUTO_INCREMENT,
  apellido VARCHAR(50) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  email VARCHAR(50) NOT NULL,

  -- Restricciones
  PRIMARY KEY (idempleado),
  UNIQUE KEY uk_email (email),

  -- Índices para mejorar búsquedas
  INDEX idx_apellido (apellido),
  INDEX idx_nombre (nombre)

) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Tabla de empleados de la empresa';

-- Insertar datos iniciales
INSERT INTO empleados (idempleado, apellido, nombre, direccion, email) VALUES
(111, 'Vélez', 'Jaime', 'Cra 1 #1-1', 'vj@gmail.com'),
(222, 'Roldan', 'Eliecer', 'Cra 2 #1-1', 're@gmail.com'),
(333, 'Perez', 'Diego', 'Cra 3 #1-1', 'pd@gmail.com'),
(444, 'Ochoa', 'Leo', 'Cra 5 #1-1', 'ol@gmail.com'),
(555, 'Roa', 'Ana', 'Cra 6 #1-1', 'ra@gmail.com');

-- Verificar la inserción
SELECT
  COUNT(*) as total_empleados,
  'Datos insertados correctamente' as estado
FROM empleados;

-- Mostrar todos los empleados
SELECT * FROM empleados ORDER BY idempleado;
