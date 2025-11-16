-- ============================================
-- Script de creación de usuario MySQL
-- Base de datos: empresa_rrhh
-- Usuario: admin_rrhh
-- ============================================

-- Nota: Este script debe ejecutarse como usuario root de MySQL
-- mysql -u root -p < create_user.sql

-- Crear usuario si no existe
-- Para localhost (conexión local)
CREATE USER IF NOT EXISTS 'admin_rrhh'@'localhost'
  IDENTIFIED BY 'Rrhh2024$ecure';

-- Para acceso remoto (opcional, descomentar si es necesario)
-- CREATE USER IF NOT EXISTS 'admin_rrhh'@'%'
--   IDENTIFIED BY 'Rrhh2024$ecure';

-- Otorgar todos los privilegios en la base de datos empresa_rrhh
GRANT ALL PRIVILEGES ON empresa_rrhh.* TO 'admin_rrhh'@'localhost';

-- Si creaste el usuario remoto, otorgar privilegios también
-- GRANT ALL PRIVILEGES ON empresa_rrhh.* TO 'admin_rrhh'@'%';

-- Privilegios específicos (alternativa más segura)
-- Descomentar estas líneas y comentar el GRANT ALL anterior si prefieres permisos limitados
/*
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER
  ON empresa_rrhh.*
  TO 'admin_rrhh'@'localhost';
*/

-- Aplicar los cambios de privilegios
FLUSH PRIVILEGES;

-- Mostrar los privilegios otorgados
SHOW GRANTS FOR 'admin_rrhh'@'localhost';

-- Verificar que el usuario fue creado
SELECT
  User,
  Host,
  authentication_string != '' as 'Has Password',
  plugin
FROM mysql.user
WHERE User = 'admin_rrhh';

-- Mensaje de confirmación
SELECT 'Usuario admin_rrhh creado exitosamente' as Estado;
