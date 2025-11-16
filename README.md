# Sistema de Gestión de Empleados

Una aplicación web moderna desarrollada con Astro.js y Tailwind CSS 4 para gestionar información de empleados.

## Características

- **CRUD Completo**: Crear, Leer, Actualizar y Eliminar empleados
- **Interfaz Moderna**: Diseño responsive con Tailwind CSS 4
- **Avatares Dinámicos**: Generación automática de avatares usando DiceBear API
- **Sin Autenticación**: Diseñado para uso local sin complejidad adicional
- **Base de Datos PostgreSQL**: Conexión directa a PostgreSQL

## Requisitos Previos

- Node.js (v18 o superior)
- MySQL 8.0+ o PostgreSQL (elige uno)
- npm o pnpm

## 🚀 Instalación Rápida (MySQL - RECOMENDADO)

### Opción A: Todo en un comando (MySQL)

**¡La forma más fácil! No necesitas crear nada manualmente.**

```bash
# 1. Importar base de datos (crea TODO automáticamente)
mysql -u root -p < empresa_rrhh_export_completo.sql

# 2. Instalar dependencias
npm install

# 3. Configurar variables de entorno
cp .env.mysql.example .env

# 4. Cambiar imports en archivos API
# En src/pages/api/empleados/index.ts
# En src/pages/api/empleados/[id].ts
# Cambiar: import { db } from '../../../lib/db';
# Por:     import { db } from '../../../lib/db-mysql';

# 5. Iniciar aplicación
npm run dev
```

**¡Listo!** La base de datos incluye 5 empleados de ejemplo.

**Credenciales creadas automáticamente:**
- Host: `localhost`
- Puerto: `3306`
- Base de datos: `empresa_rrhh`
- Usuario: `admin_rrhh`
- Contraseña: `Rrhh2024$ecure`

---

## Instalación Manual (PostgreSQL)

### 1. Clonar el repositorio

```bash
git clone <tu-repositorio>
cd employee-database-practice
```

### 2. Instalar dependencias

```bash
npm install
```

### 3. Configurar la base de datos

Crea una base de datos en PostgreSQL y ejecuta el siguiente script SQL:

```sql
CREATE TABLE empleados (
  idempleado SERIAL PRIMARY KEY,
  apellido VARCHAR(50) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  email VARCHAR(50) NOT NULL
);
```

### 4. Configurar variables de entorno

Copia el archivo `.env.example` a `.env`:

```bash
cp .env.example .env
```

Edita el archivo `.env` con los datos de tu base de datos local:

```env
DB_HOST=localhost
DB_PORT=5432
DB_NAME=empleados_db
DB_USER=postgres
DB_PASSWORD=tu_password
```

## Uso

### Modo Desarrollo

```bash
npm run dev
```

La aplicación estará disponible en `http://localhost:4321`

### Compilar para Producción

```bash
npm run build
```

### Vista Previa de Producción

```bash
npm run preview
```

## Estructura del Proyecto

```
employee-database-practice/
├── src/
│   ├── layouts/
│   │   └── Layout.astro          # Layout principal
│   ├── lib/
│   │   └── db.ts                 # Módulo de conexión a base de datos
│   ├── pages/
│   │   ├── api/
│   │   │   └── empleados/
│   │   │       ├── index.ts      # API endpoints (GET, POST)
│   │   │       └── [id].ts       # API endpoints (GET, PUT, DELETE)
│   │   └── index.astro           # Página principal
│   └── env.d.ts                  # Tipos TypeScript para variables de entorno
├── .env.example                   # Ejemplo de variables de entorno
├── astro.config.mjs              # Configuración de Astro
├── tailwind.config.mjs           # Configuración de Tailwind
├── tsconfig.json                 # Configuración de TypeScript
└── package.json
```

## API Endpoints

### Empleados

- `GET /api/empleados` - Obtener todos los empleados
- `POST /api/empleados` - Crear un nuevo empleado
- `GET /api/empleados/:id` - Obtener un empleado por ID
- `PUT /api/empleados/:id` - Actualizar un empleado
- `DELETE /api/empleados/:id` - Eliminar un empleado

### Ejemplo de uso de la API

#### Crear un empleado

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

## Funcionalidades de la Interfaz

### Listado de Empleados

- Visualización en tarjetas con diseño moderno
- Avatar único generado automáticamente para cada empleado
- Información completa: nombre, apellido, email y dirección

### Agregar Empleado

1. Clic en el botón "Agregar Nuevo Empleado"
2. Completar el formulario modal
3. Clic en "Guardar"

### Editar Empleado

1. Clic en el botón "Editar" en la tarjeta del empleado
2. Modificar los datos en el formulario modal
3. Clic en "Guardar"

### Eliminar Empleado

1. Clic en el botón "Eliminar" en la tarjeta del empleado
2. Confirmar la eliminación en el diálogo

## Avatares

Los avatares se generan automáticamente usando la API de DiceBear (https://api.dicebear.com/).
Cada empleado tiene un avatar único basado en su nombre y apellido.

## Tecnologías Utilizadas

- **Astro.js**: Framework web moderno
- **Tailwind CSS 4**: Framework de CSS utility-first
- **TypeScript**: Tipado estático para JavaScript
- **MySQL / PostgreSQL**: Base de datos relacional (soporta ambas)
- **mysql2**: Cliente MySQL para Node.js
- **node-postgres (pg)**: Cliente PostgreSQL para Node.js
- **DiceBear API**: Generación de avatares

## Solución de Problemas

### Error de conexión a la base de datos

Verifica que:
- PostgreSQL esté corriendo
- Las credenciales en `.env` sean correctas
- La base de datos y la tabla existan
- El usuario tenga permisos suficientes

### Error al cargar empleados

Revisa la consola del navegador y los logs del servidor para más detalles.

## Licencia

MIT
