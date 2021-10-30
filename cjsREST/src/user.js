import express from 'express';
import pool from './connect.js';
import bcrypt from 'bcrypt';

const router = express.Router();

router.get('/',async(req, res) => {
    try {
        const users = await pool.query('SELECT * FROM USUARIOS');
        res.json({users:users.rows});
    }catch (error) {
        res.status(500).json({error : error.message});
    }
})

router.post('/',async(req,res) => {
    try {
        const hpass = await bcrypt.hash(req.body.password, 10);
        const user = await pool.query(
            'INSERT INTO USUARIOS (EMAIL,PASS) VALUES ($1,$2) RETURNING *',
            [req.body.email, hpass]);
        res.jsos({users:user.rows[0]});
    } catch(error){
        res.status(500).json({error : error.message});
    }
})

export default router;