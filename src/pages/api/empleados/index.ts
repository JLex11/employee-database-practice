import type { APIRoute } from 'astro';
import { db } from '../../../lib/db';

// GET /api/empleados - Obtener todos los empleados
export const GET: APIRoute = async () => {
  try {
    const empleados = await db.getAllEmpleados();
    return new Response(JSON.stringify(empleados), {
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    console.error('Error al obtener empleados:', error);
    return new Response(JSON.stringify({ error: 'Error al obtener empleados' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    });
  }
};

// POST /api/empleados - Crear nuevo empleado
export const POST: APIRoute = async ({ request }) => {
  try {
    const body = await request.json();
    const { apellido, nombre, direccion, email } = body;

    if (!apellido || !nombre || !direccion || !email) {
      return new Response(JSON.stringify({ error: 'Todos los campos son requeridos' }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' }
      });
    }

    const empleado = await db.createEmpleado({ apellido, nombre, direccion, email });
    return new Response(JSON.stringify(empleado), {
      status: 201,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    console.error('Error al crear empleado:', error);
    return new Response(JSON.stringify({ error: 'Error al crear empleado' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    });
  }
};
