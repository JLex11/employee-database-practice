# Quick Start - 5 Minutes

## Requirements
- MySQL installed
- Node.js installed

## Step 1: Create MySQL User

```bash
mysql -u root -p
```

Inside MySQL console:

```sql
CREATE USER IF NOT EXISTS 'admin_rrhh'@'localhost' IDENTIFIED BY 'Rrhh2024$ecure';
GRANT ALL PRIVILEGES ON *.* TO 'admin_rrhh'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT;
```

## Step 2: Import Database

```bash
mysql -u root -p < empresa_rrhh_export_completo.sql
```

**✅ This automatically creates:**
- ✅ Database `empresa_rrhh`
- ✅ Table `empleados`
- ✅ 5 sample employees

## Step 3: Install Dependencies

```bash
npm install
```

## Step 4: Configure Environment Variables

```bash
cp .env.mysql.example .env
```

The `.env` file contains the correct credentials:
```env
DB_HOST=localhost
DB_PORT=3306
DB_NAME=empresa_rrhh
DB_USER=admin_rrhh
DB_PASSWORD=Rrhh2024$ecure
```

## Step 5: Update API Imports

Open these 2 files and change the import:

**File 1:** `src/pages/api/empleados/index.ts`
```typescript
// Change this line:
import { db } from '../../../lib/db';

// To this:
import { db } from '../../../lib/db-mysql';
```

**File 2:** `src/pages/api/empleados/[id].ts`
```typescript
// Change this line:
import { db } from '../../../lib/db';

// To this:
import { db } from '../../../lib/db-mysql';
```

## Step 6: Start Application

```bash
npm run dev
```

## 🎉 Done!

Open your browser at: **http://localhost:4321**

You will see 5 sample employees:
- Jaime Vélez
- Eliecer Roldan
- Diego Perez
- Leo Ochoa
- Ana Roa

---

## Verify Everything Works

To verify the database was imported correctly:

```bash
mysql -u admin_rrhh -p
# Password: Rrhh2024$ecure
```

Inside MySQL:
```sql
USE empresa_rrhh;
SELECT * FROM empleados;
```

You should see the 5 employees listed.

---

## Troubleshooting

### Error: "Access denied for user 'admin_rrhh'"

Make sure you completed Step 1 (create user) and your `.env` file has the correct credentials.

### Error: "Unknown database 'empresa_rrhh'"

Run Step 2 again (import database).

### Browser error: "Failed to fetch"

Verify that:
1. MySQL is running: `sudo systemctl status mysql`
2. Imports are updated (Step 5)
3. Environment variables are correct (Step 4)
