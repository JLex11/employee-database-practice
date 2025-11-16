# ⚡ Inicio Rápido - 5 minutos

## Requisitos
- MySQL instalado
- Node.js instalado

## Paso 1: Importar base de datos

```bash
mysql -u root -p < empresa_rrhh_export_completo.sql
```

Cuando te pida la contraseña, ingresa tu contraseña de **root** de MySQL.

**✅ Esto crea automáticamente:**
- ✅ La base de datos `empresa_rrhh`
- ✅ El usuario `admin_rrhh` con contraseña `Rrhh2024$ecure`
- ✅ La tabla `empleados`
- ✅ 5 empleados de ejemplo

## Paso 2: Instalar dependencias

```bash
npm install
```

## Paso 3: Configurar variables de entorno

```bash
cp .env.mysql.example .env
```

El archivo `.env` ya contiene las credenciales correctas:
```env
DB_HOST=localhost
DB_PORT=3306
DB_NAME=empresa_rrhh
DB_USER=admin_rrhh
DB_PASSWORD=Rrhh2024$ecure
```

## Paso 4: Actualizar imports en archivos API

Abre estos 2 archivos y cambia el import:

**Archivo 1:** `src/pages/api/empleados/index.ts`
```typescript
// Cambiar esta línea:
import { db } from '../../../lib/db';

// Por esta:
import { db } from '../../../lib/db-mysql';
```

**Archivo 2:** `src/pages/api/empleados/[id].ts`
```typescript
// Cambiar esta línea:
import { db } from '../../../lib/db';

// Por esta:
import { db } from '../../../lib/db-mysql';
```

## Paso 5: Iniciar la aplicación

```bash
npm run dev
```

## 🎉 ¡Listo!

Abre tu navegador en: **http://localhost:4321**

Verás 5 empleados de ejemplo:
- Jaime Vélez
- Eliecer Roldan
- Diego Perez
- Leo Ochoa
- Ana Roa

---

## Verificar que todo funciona

Si quieres verificar que la base de datos se importó correctamente:

```bash
mysql -u admin_rrhh -p
# Contraseña: Rrhh2024$ecure
```

Dentro de MySQL:
```sql
USE empresa_rrhh;
SELECT * FROM empleados;
```

Deberías ver los 5 empleados listados.

---

## ¿Problemas?

### Error: "Access denied for user 'admin_rrhh'"

Revisa que tu archivo `.env` tenga las credenciales correctas.

### Error: "Unknown database 'empresa_rrhh'"

Ejecuta nuevamente el paso 1 (importar base de datos).

### Error en el navegador: "Failed to fetch"

Verifica que:
1. MySQL esté corriendo: `sudo systemctl status mysql`
2. Los imports estén actualizados (Paso 4)
3. Las variables de entorno estén correctas (Paso 3)
