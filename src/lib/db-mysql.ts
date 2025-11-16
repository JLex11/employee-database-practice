import mysql from 'mysql2/promise';

// Crear pool de conexiones
const pool = mysql.createPool({
  host: import.meta.env.DB_HOST,
  port: parseInt(import.meta.env.DB_PORT || '3306'),
  database: import.meta.env.DB_NAME,
  user: import.meta.env.DB_USER,
  password: import.meta.env.DB_PASSWORD,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  charset: 'utf8mb4'
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
    const [rows] = await pool.query('SELECT * FROM empleados ORDER BY idempleado');
    return rows as Empleado[];
  },

  async getEmpleadoById(id: number): Promise<Empleado | null> {
    const [rows] = await pool.query('SELECT * FROM empleados WHERE idempleado = ?', [id]);
    const empleados = rows as Empleado[];
    return empleados[0] || null;
  },

  async createEmpleado(empleado: Omit<Empleado, 'idempleado'>): Promise<Empleado> {
    const [result] = await pool.query(
      'INSERT INTO empleados (apellido, nombre, direccion, email) VALUES (?, ?, ?, ?)',
      [empleado.apellido, empleado.nombre, empleado.direccion, empleado.email]
    );

    const insertResult = result as mysql.ResultSetHeader;
    const [rows] = await pool.query('SELECT * FROM empleados WHERE idempleado = ?', [insertResult.insertId]);
    const empleados = rows as Empleado[];
    return empleados[0];
  },

  async updateEmpleado(id: number, empleado: Partial<Omit<Empleado, 'idempleado'>>): Promise<Empleado | null> {
    const fields = [];
    const values = [];

    if (empleado.apellido !== undefined) {
      fields.push('apellido = ?');
      values.push(empleado.apellido);
    }
    if (empleado.nombre !== undefined) {
      fields.push('nombre = ?');
      values.push(empleado.nombre);
    }
    if (empleado.direccion !== undefined) {
      fields.push('direccion = ?');
      values.push(empleado.direccion);
    }
    if (empleado.email !== undefined) {
      fields.push('email = ?');
      values.push(empleado.email);
    }

    if (fields.length === 0) return null;

    values.push(id);
    const query = `UPDATE empleados SET ${fields.join(', ')} WHERE idempleado = ?`;

    await pool.query(query, values);

    const [rows] = await pool.query('SELECT * FROM empleados WHERE idempleado = ?', [id]);
    const empleados = rows as Empleado[];
    return empleados[0] || null;
  },

  async deleteEmpleado(id: number): Promise<boolean> {
    const [result] = await pool.query('DELETE FROM empleados WHERE idempleado = ?', [id]);
    const deleteResult = result as mysql.ResultSetHeader;
    return deleteResult.affectedRows > 0;
  }
};
