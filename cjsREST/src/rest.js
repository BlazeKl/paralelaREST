import express from 'express';
import pool from './connect.js';
import bcrypt from 'bcrypt';
import { authenticationToken } from '../middleware/authmid.js';

const router = express.Router();

// Plantillas de GET y POST
// GET
// router.get('/',authenticationToken,async(req, res) => {
//     try {
//     }catch (error) {
//         res.status(500).json({error : error.message});
//     }
// })

// POST
// router.post('/',authenticationToken,async(req,res) => {
//     try {       
//     } catch(error){
//         res.status(500).json({error : error.message});
//     }
// })

router.get('/stations',authenticationToken,async(req, res) => {
    try {
        const stations = await pool.query('SELECT DISTINCT ON (ESTACION) ESTACION FROM TEMPERATURAS');
        res.json({stations:stations.rows});
    }catch (error) {
        res.status(500).json({error : error.message});
    }
})

POST
router.post('/search',authenticationToken,async(req,res) => {
    try {
        
    } catch(error){
        res.status(500).json({error : error.message});
    }
})

export default router;