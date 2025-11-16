# Importación y Configuración de MySQL/InnoDB

Este directorio contiene los archivos SQL necesarios para configurar la base de datos MySQL.

## Archivos disponibles

- **empresa_rrhh_dump.sql** - Exportación completa usando mysqldump (incluye todas las directivas)
- **setup_mysql.sql** - Script simplificado para crear base de datos desde cero
- **create_user.sql** - Script para crear usuario de base de datos

## Opción 1: Importar desde el dump completo

### Método 1: Desde línea de comandos

```bash
# Importar la base de datos completa
mysql -u root -p < database/empresa_rrhh_dump.sql

# O especificando el host
mysql -h localhost -u root -p < database/empresa_rrhh_dump.sql
```

### Método 2: Desde MySQL CLI

```bash
# Conectar a MySQL
mysql -u root -p

# Dentro de MySQL, ejecutar:
source /ruta/completa/database/empresa_rrhh_dump.sql;
```

## Opción 2: Usar el script de setup simplificado

```bash
# Conectar a MySQL
mysql -u root -p

# Ejecutar el script
source /ruta/completa/database/setup_mysql.sql;
```

## Crear usuario para la aplicación

```bash
# Ejecutar el script de creación de usuario
mysql -u root -p < database/create_user.sql
```

O manualmente:

```sql
-- Conectar como root
mysql -u root -p

-- Crear usuario
CREATE USER IF NOT EXISTS 'admin_rrhh'@'localhost'
  IDENTIFIED BY 'Rrhh2024$ecure';

-- Otorgar permisos
GRANT ALL PRIVILEGES ON empresa_rrhh.* TO 'admin_rrhh'@'localhost';

-- Aplicar cambios
FLUSH PRIVILEGES;
```

## Configurar variables de entorno

1. Copiar el archivo de ejemplo:
```bash
cp .env.mysql.example .env
```

2. Editar `.env` con tus credenciales:
```env
DB_HOST=localhost
DB_PORT=3306
DB_NAME=empresa_rrhh
DB_USER=admin_rrhh
DB_PASSWORD=Rrhh2024$ecure
```

## Verificar la importación

```sql
-- Conectar a la base de datos
USE empresa_rrhh;

-- Verificar que la tabla existe
SHOW TABLES;

-- Ver la estructura de la tabla
DESCRIBE empleados;

-- Contar registros
SELECT COUNT(*) FROM empleados;

-- Ver todos los empleados
SELECT * FROM empleados;
```

Deberías ver 5 empleados:
- 111 - Jaime Vélez
- 222 - Eliecer Roldan
- 333 - Diego Perez
- 444 - Leo Ochoa
- 555 - Ana Roa

## Comandos útiles de MySQL

### Exportar la base de datos

```bash
# Exportación completa
mysqldump -u admin_rrhh -p empresa_rrhh > backup_$(date +%Y%m%d).sql

# Solo estructura (sin datos)
mysqldump -u admin_rrhh -p --no-data empresa_rrhh > estructura.sql

# Solo datos (sin estructura)
mysqldump -u admin_rrhh -p --no-create-info empresa_rrhh > datos.sql
```

### Backup y restauración

```bash
# Crear backup
mysqldump -u admin_rrhh -p empresa_rrhh > backup.sql

# Restaurar backup
mysql -u admin_rrhh -p empresa_rrhh < backup.sql
```

## Solución de problemas

### Error de conexión

```bash
# Verificar que MySQL está corriendo
sudo systemctl status mysql

# O en macOS con Homebrew
brew services list | grep mysql
```

### Error de permisos

```sql
-- Verificar permisos del usuario
SHOW GRANTS FOR 'admin_rrhh'@'localhost';

-- Re-otorgar permisos si es necesario
GRANT ALL PRIVILEGES ON empresa_rrhh.* TO 'admin_rrhh'@'localhost';
FLUSH PRIVILEGES;
```

### Error de charset

Si tienes problemas con caracteres especiales (tildes, ñ):

```sql
-- Verificar charset de la base de datos
SELECT default_character_set_name, default_collation_name
FROM information_schema.schemata
WHERE schema_name = 'empresa_rrhh';

-- Cambiar charset si es necesario
ALTER DATABASE empresa_rrhh
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
```

## Información de la base de datos

- **Nombre**: empresa_rrhh
- **Motor**: InnoDB
- **Charset**: utf8mb4
- **Collation**: utf8mb4_unicode_ci
- **Usuario**: admin_rrhh
- **Contraseña**: Rrhh2024$ecure (cámbiala en producción)

## Estructura de la tabla empleados

```
+-------------+--------------+------+-----+---------+-------+
| Field       | Type         | Null | Key | Default | Extra |
+-------------+--------------+------+-----+---------+-------+
| idempleado  | int          | NO   | PRI | NULL    |       |
| apellido    | varchar(50)  | NO   | MUL | NULL    |       |
| nombre      | varchar(50)  | NO   |     | NULL    |       |
| direccion   | varchar(100) | NO   |     | NULL    |       |
| email       | varchar(50)  | NO   | UNI | NULL    |       |
+-------------+--------------+------+-----+---------+-------+
```

### Índices

- **PRIMARY KEY**: idempleado
- **UNIQUE KEY**: email (uk_email)
- **INDEX**: apellido (idx_apellido)
- **INDEX**: nombre (idx_nombre)
