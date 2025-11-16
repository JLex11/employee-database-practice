# Guía Completa de Importación - Base de Datos MySQL

Esta guía te ayudará a importar y configurar la base de datos MySQL con los datos de empleados.

## Requisitos Previos

- MySQL 8.0 o superior instalado
- Acceso root a MySQL
- Cliente MySQL (mysql CLI) instalado

## Paso 1: Verificar MySQL

Verifica que MySQL esté instalado y corriendo:

```bash
# En Linux
sudo systemctl status mysql

# En macOS
brew services list | grep mysql

# En Windows
net start | findstr MySQL
```

Si no está corriendo, inícialo:

```bash
# Linux
sudo systemctl start mysql

# macOS
brew services start mysql

# Windows
net start MySQL80
```

## Paso 2: Conectar como root

```bash
mysql -u root -p
```

Ingresa tu contraseña de root cuando se solicite.

## Paso 3: Crear el usuario de aplicación

Desde el cliente MySQL, ejecuta:

```sql
-- Crear usuario
CREATE USER IF NOT EXISTS 'admin_rrhh'@'localhost'
  IDENTIFIED BY 'Rrhh2024$ecure';

-- Otorgar permisos
GRANT ALL PRIVILEGES ON *.* TO 'admin_rrhh'@'localhost'
  WITH GRANT OPTION;

-- Aplicar cambios
FLUSH PRIVILEGES;

-- Salir de MySQL
EXIT;
```

**Importante**: Cambia la contraseña `Rrhh2024$ecure` por una segura.

## Paso 4: Importar la base de datos

### Opción A: Usando el dump completo (RECOMENDADO)

Desde la terminal (NO desde MySQL):

```bash
# Navegar al directorio del proyecto
cd /ruta/a/employee-database-practice

# Importar usando el usuario creado
mysql -u admin_rrhh -p < database/empresa_rrhh_dump.sql
```

### Opción B: Usando el script de setup

```bash
mysql -u admin_rrhh -p < database/setup_mysql.sql
```

### Opción C: Desde el cliente MySQL

```bash
# Conectar a MySQL
mysql -u admin_rrhh -p

# Ejecutar el script
SOURCE /ruta/completa/employee-database-practice/database/empresa_rrhh_dump.sql;

# O el script de setup
SOURCE /ruta/completa/employee-database-practice/database/setup_mysql.sql;
```

## Paso 5: Verificar la importación

```bash
# Conectar a MySQL
mysql -u admin_rrhh -p

# Usar la base de datos
USE empresa_rrhh;

# Ver las tablas
SHOW TABLES;

# Ver la estructura de la tabla
DESCRIBE empleados;

# Ver los datos
SELECT * FROM empleados;
```

Deberías ver algo como:

```
+-------------+----------+--------+-------------+----------------+
| idempleado  | apellido | nombre | direccion   | email          |
+-------------+----------+--------+-------------+----------------+
|         111 | Vélez    | Jaime  | Cra 1 #1-1  | vj@gmail.com   |
|         222 | Roldan   | Eliecer| Cra 2 #1-1  | re@gmail.com   |
|         333 | Perez    | Diego  | Cra 3 #1-1  | pd@gmail.com   |
|         444 | Ochoa    | Leo    | Cra 5 #1-1  | ol@gmail.com   |
|         555 | Roa      | Ana    | Cra 6 #1-1  | ra@gmail.com   |
+-------------+----------+--------+-------------+----------------+
5 rows in set (0.00 sec)
```

## Paso 6: Configurar las variables de entorno

### 6.1 Copiar el archivo de ejemplo

```bash
# En el directorio del proyecto
cp .env.mysql.example .env
```

### 6.2 Editar el archivo .env

```bash
# Usa tu editor favorito
nano .env
# o
vim .env
# o
code .env
```

Contenido del `.env`:

```env
DB_HOST=localhost
DB_PORT=3306
DB_NAME=empresa_rrhh
DB_USER=admin_rrhh
DB_PASSWORD=Rrhh2024$ecure
```

**Importante**: Usa la misma contraseña que configuraste en el Paso 3.

## Paso 7: Configurar la aplicación para MySQL

### 7.1 Modificar los archivos de API

Necesitas cambiar la importación de la base de datos en los archivos de API:

**En `src/pages/api/empleados/index.ts`:**

Cambia:
```typescript
import { db } from '../../../lib/db';
```

Por:
```typescript
import { db } from '../../../lib/db-mysql';
```

**En `src/pages/api/empleados/[id].ts`:**

Cambia:
```typescript
import { db } from '../../../lib/db';
```

Por:
```typescript
import { db } from '../../../lib/db-mysql';
```

### 7.2 O crear un archivo de configuración (ALTERNATIVA MEJOR)

Crea `src/lib/db-config.ts`:

```typescript
// Si DB_TYPE está definido y es 'mysql', usar MySQL, sino PostgreSQL
const dbType = import.meta.env.DB_TYPE || 'postgres';

export { db } from dbType === 'mysql' ? './db-mysql' : './db';
```

Luego en tus archivos de API importa:
```typescript
import { db } from '../../../lib/db-config';
```

Y en tu `.env` agrega:
```env
DB_TYPE=mysql
```

## Paso 8: Instalar dependencias

```bash
npm install
```

Esto instalará `mysql2` junto con las otras dependencias.

## Paso 9: Iniciar la aplicación

```bash
npm run dev
```

La aplicación debería iniciar en `http://localhost:4321`

## Solución de Problemas

### Error: "Access denied for user"

- Verifica que el usuario y contraseña en `.env` coincidan con los creados en MySQL
- Asegúrate de haber ejecutado `FLUSH PRIVILEGES`

```sql
-- Verificar el usuario
SELECT User, Host FROM mysql.user WHERE User = 'admin_rrhh';

-- Verificar permisos
SHOW GRANTS FOR 'admin_rrhh'@'localhost';
```

### Error: "Unknown database 'empresa_rrhh'"

La base de datos no fue creada. Ejecuta:

```sql
CREATE DATABASE empresa_rrhh
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
```

### Error de conexión desde la aplicación

1. Verifica que MySQL esté corriendo:
```bash
sudo systemctl status mysql
```

2. Verifica las variables de entorno:
```bash
cat .env
```

3. Prueba la conexión manualmente:
```bash
mysql -h localhost -P 3306 -u admin_rrhh -p empresa_rrhh
```

### Problemas con caracteres especiales

Si las tildes o eñes no se muestran correctamente:

```sql
-- Verificar el charset
SHOW VARIABLES LIKE 'character_set%';

-- Cambiar si es necesario
ALTER DATABASE empresa_rrhh
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

ALTER TABLE empleados
  CONVERT TO CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
```

## Comandos útiles de MySQL

### Ver bases de datos
```sql
SHOW DATABASES;
```

### Ver tablas
```sql
USE empresa_rrhh;
SHOW TABLES;
```

### Ver estructura de tabla
```sql
DESCRIBE empleados;
SHOW CREATE TABLE empleados;
```

### Contar registros
```sql
SELECT COUNT(*) FROM empleados;
```

### Hacer backup
```bash
mysqldump -u admin_rrhh -p empresa_rrhh > backup_$(date +%Y%m%d_%H%M%S).sql
```

### Restaurar backup
```bash
mysql -u admin_rrhh -p empresa_rrhh < backup.sql
```

## Resumen de credenciales

- **Base de datos**: `empresa_rrhh`
- **Usuario**: `admin_rrhh`
- **Contraseña**: `Rrhh2024$ecure` (¡cámbiala!)
- **Host**: `localhost`
- **Puerto**: `3306`
- **Charset**: `utf8mb4`
- **Collation**: `utf8mb4_unicode_ci`

## Siguiente paso

Una vez importada la base de datos y configurada la aplicación, deberías poder:

1. Ver los 5 empleados iniciales en la interfaz web
2. Agregar nuevos empleados
3. Editar empleados existentes
4. Eliminar empleados

¡Listo! Tu aplicación debería estar funcionando con MySQL.
