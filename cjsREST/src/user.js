import express from 'express';
import pool from './connect.js';
import bcrypt from 'bcryptjs';
import { authenticationToken } from '../middleware/authmid.js';

const router = express.Router();

router.get('/',authenticationToken,async(req, res) => {
    try {
        const users = await pool.query('SELECT * FROM USUARIOS');
        res.json({users:users.rows});
    }catch (error) {
        res.status(500).json({error : error.message});
    }
})

router.post('/',async(req,res) => {
    try {
        if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(req.body.email))
        {
            const hpass = await bcrypt.hash(req.body.password, 10);
            const users = await pool.query(
            'INSERT INTO USUARIOS (EMAIL,PASS) VALUES ($1,$2) RETURNING *',
            [req.body.email, hpass]);
            res.json({users:users.rows[0]});
        } else
        {
            return res.status(400).json({error : error.message});
        }
        
    } catch(error){
        res.status(500).json({error : error.message});
    }
})

export default router;