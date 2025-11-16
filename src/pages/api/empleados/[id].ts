import type { APIRoute } from 'astro';
import { db } from '../../../lib/db';

// GET /api/empleados/:id - Obtener un empleado por ID
export const GET: APIRoute = async ({ params }) => {
  try {
    const id = parseInt(params.id || '0');
    const empleado = await db.getEmpleadoById(id);

    if (!empleado) {
      return new Response(JSON.stringify({ error: 'Empleado no encontrado' }), {
        status: 404,
        headers: { 'Content-Type': 'application/json' }
      });
    }

    return new Response(JSON.stringify(empleado), {
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    console.error('Error al obtener empleado:', error);
    return new Response(JSON.stringify({ error: 'Error al obtener empleado' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    });
  }
};

// PUT /api/empleados/:id - Actualizar empleado
export const PUT: APIRoute = async ({ params, request }) => {
  try {
    const id = parseInt(params.id || '0');
    const body = await request.json();

    const empleado = await db.updateEmpleado(id, body);

    if (!empleado) {
      return new Response(JSON.stringify({ error: 'Empleado no encontrado' }), {
        status: 404,
        headers: { 'Content-Type': 'application/json' }
      });
    }

    return new Response(JSON.stringify(empleado), {
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    console.error('Error al actualizar empleado:', error);
    return new Response(JSON.stringify({ error: 'Error al actualizar empleado' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    });
  }
};

// DELETE /api/empleados/:id - Eliminar empleado
export const DELETE: APIRoute = async ({ params }) => {
  try {
    const id = parseInt(params.id || '0');
    const success = await db.deleteEmpleado(id);

    if (!success) {
      return new Response(JSON.stringify({ error: 'Empleado no encontrado' }), {
        status: 404,
        headers: { 'Content-Type': 'application/json' }
      });
    }

    return new Response(JSON.stringify({ message: 'Empleado eliminado correctamente' }), {
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    console.error('Error al eliminar empleado:', error);
    return new Response(JSON.stringify({ error: 'Error al eliminar empleado' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    });
  }
};
