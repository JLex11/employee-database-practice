# Employee Management System

A modern web application built with Astro.js and Tailwind CSS 4 to manage employee information.

## Features

- **Complete CRUD**: Create, Read, Update and Delete employees
- **Modern Interface**: Responsive design with Tailwind CSS 4
- **Dynamic Avatars**: Automatic avatar generation using DiceBear API
- **No Authentication**: Designed for local use without added complexity
- **Database Support**: Works with both MySQL and PostgreSQL

## Prerequisites

- Node.js (v18 or higher)
- MySQL 8.0+ or PostgreSQL (choose one)
- npm or pnpm

## 🚀 Quick Install (MySQL - RECOMMENDED)

### Option A: MySQL Setup

```bash
# 1. Create MySQL user
mysql -u root -p
```

Inside MySQL console:
```sql
CREATE USER IF NOT EXISTS 'admin_rrhh'@'localhost' IDENTIFIED BY 'Rrhh2024$ecure';
GRANT ALL PRIVILEGES ON *.* TO 'admin_rrhh'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT;
```

```bash
# 2. Import database
mysql -u root -p < empresa_rrhh_export_completo.sql

# 3. Install dependencies
npm install

# 4. Configure environment variables
cp .env.mysql.example .env

# 5. Update imports in API files
# In src/pages/api/empleados/index.ts
# In src/pages/api/empleados/[id].ts
# Change: import { db } from '../../../lib/db';
# To:     import { db } from '../../../lib/db-mysql';

# 6. Start application
npm run dev
```

**Done!** Database includes 5 sample employees.

**Database credentials:**
- Host: `localhost`
- Port: `3306`
- Database: `empresa_rrhh`
- User: `admin_rrhh`
- Password: `Rrhh2024$ecure`

---

## Manual Setup (PostgreSQL)

### 1. Clone Repository

```bash
git clone <your-repository>
cd employee-database-practice
```

### 2. Install Dependencies

```bash
npm install
```

### 3. Setup Database

Create a PostgreSQL database and run this SQL script:

```sql
CREATE TABLE empleados (
  idempleado SERIAL PRIMARY KEY,
  apellido VARCHAR(50) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  email VARCHAR(50) NOT NULL
);
```

### 4. Configure Environment Variables

Copy `.env.example` to `.env`:

```bash
cp .env.example .env
```

Edit `.env` file with your database credentials:

```env
DB_HOST=localhost
DB_PORT=5432
DB_NAME=empleados_db
DB_USER=postgres
DB_PASSWORD=your_password
```

## Usage

### Development Mode

```bash
npm run dev
```

Application will be available at `http://localhost:4321`

### Build for Production

```bash
npm run build
```

### Production Preview

```bash
npm run preview
```

## Project Structure

```
employee-database-practice/
├── src/
│   ├── layouts/
│   │   └── Layout.astro          # Main layout
│   ├── lib/
│   │   ├── db.ts                 # PostgreSQL connection module
│   │   └── db-mysql.ts           # MySQL connection module
│   ├── pages/
│   │   ├── api/
│   │   │   └── empleados/
│   │   │       ├── index.ts      # API endpoints (GET, POST)
│   │   │       └── [id].ts       # API endpoints (GET, PUT, DELETE)
│   │   └── index.astro           # Main page
│   └── env.d.ts                  # TypeScript types for environment variables
├── .env.example                   # Environment variables example
├── astro.config.mjs              # Astro configuration
├── tailwind.config.mjs           # Tailwind configuration
├── tsconfig.json                 # TypeScript configuration
└── package.json
```

## API Endpoints

### Employees

- `GET /api/empleados` - Get all employees
- `POST /api/empleados` - Create a new employee
- `GET /api/empleados/:id` - Get employee by ID
- `PUT /api/empleados/:id` - Update employee
- `DELETE /api/empleados/:id` - Delete employee

### API Usage Example

#### Create an employee

```bash
curl -X POST http://localhost:4321/api/empleados \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Juan",
    "apellido": "Pérez",
    "email": "juan.perez@example.com",
    "direccion": "Calle Principal 123"
  }'
```

## Interface Features

### Employee List

- Modern card-based design
- Unique avatar generated automatically for each employee
- Complete information: name, surname, email and address

### Add Employee

1. Click "Agregar Nuevo Empleado" button
2. Fill out the modal form
3. Click "Guardar"

### Edit Employee

1. Click "Editar" button on employee card
2. Modify data in modal form
3. Click "Guardar"

### Delete Employee

1. Click "Eliminar" button on employee card
2. Confirm deletion in dialog

## Avatars

Avatars are automatically generated using DiceBear API (https://api.dicebear.com/).
Each employee has a unique avatar based on their name and surname.

## Technologies Used

- **Astro.js**: Modern web framework
- **Tailwind CSS 4**: Utility-first CSS framework
- **TypeScript**: Static typing for JavaScript
- **MySQL / PostgreSQL**: Relational database (supports both)
- **mysql2**: MySQL client for Node.js
- **node-postgres (pg)**: PostgreSQL client for Node.js
- **DiceBear API**: Avatar generation

## Troubleshooting

### Database connection error

Verify that:
- MySQL/PostgreSQL is running
- Credentials in `.env` are correct
- Database and table exist
- User has sufficient permissions

### Error loading employees

Check browser console and server logs for details.

## License

MIT
