const Pool = require('pg').Pool
const pool = new Pool({
  user: 'clima',
  host: 'localhost',
  database: 'climadb',
  password: 'patata2021',
  port: 5432,
})

