import pg from 'pg';

const {Pool} = pg;
let localPoolConfig = {
  user: 'clima',
  host: 'localhost',
  database: 'climadb',
  password: 'patata2021',
  port: 5432,
}

const pool = new Pool(localPoolConfig);
export default pool;