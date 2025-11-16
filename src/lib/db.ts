import pg from 'pg';

const { Pool } = pg;

const pool = new Pool({
  host: import.meta.env.DB_HOST,
  port: parseInt(import.meta.env.DB_PORT || '5432'),
  database: import.meta.env.DB_NAME,
  user: import.meta.env.DB_USER,
  password: import.meta.env.DB_PASSWORD,
});

export interface Empleado {
  idempleado: number;
  apellido: string;
  nombre: string;
  direccion: string;
  email: string;
}

export const db = {
  async getAllEmpleados(): Promise<Empleado[]> {
    const result = await pool.query('SELECT * FROM empleados ORDER BY idempleado');
    return result.rows;
  },

  async getEmpleadoById(id: number): Promise<Empleado | null> {
    const result = await pool.query('SELECT * FROM empleados WHERE idempleado = $1', [id]);
    return result.rows[0] || null;
  },

  async createEmpleado(empleado: Omit<Empleado, 'idempleado'>): Promise<Empleado> {
    const result = await pool.query(
      'INSERT INTO empleados (apellido, nombre, direccion, email) VALUES ($1, $2, $3, $4) RETURNING *',
      [empleado.apellido, empleado.nombre, empleado.direccion, empleado.email]
    );
    return result.rows[0];
  },

  async updateEmpleado(id: number, empleado: Partial<Omit<Empleado, 'idempleado'>>): Promise<Empleado | null> {
    const fields = [];
    const values = [];
    let paramCount = 1;

    if (empleado.apellido !== undefined) {
      fields.push(`apellido = $${paramCount++}`);
      values.push(empleado.apellido);
    }
    if (empleado.nombre !== undefined) {
      fields.push(`nombre = $${paramCount++}`);
      values.push(empleado.nombre);
    }
    if (empleado.direccion !== undefined) {
      fields.push(`direccion = $${paramCount++}`);
      values.push(empleado.direccion);
    }
    if (empleado.email !== undefined) {
      fields.push(`email = $${paramCount++}`);
      values.push(empleado.email);
    }

    if (fields.length === 0) return null;

    values.push(id);
    const query = `UPDATE empleados SET ${fields.join(', ')} WHERE idempleado = $${paramCount} RETURNING *`;
    const result = await pool.query(query, values);
    return result.rows[0] || null;
  },

  async deleteEmpleado(id: number): Promise<boolean> {
    const result = await pool.query('DELETE FROM empleados WHERE idempleado = $1', [id]);
    return result.rowCount !== null && result.rowCount > 0;
  }
};
