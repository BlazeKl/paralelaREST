import express from 'express';
import pool from './connect.js';
import bcrypt from 'bcryptjs';
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


//GET retorna el nombre de las estaciones
router.get('/stations',authenticationToken,async(req, res) => {
    try {
        const stations = await pool.query('SELECT DISTINCT ON (ESTACION) ESTACION FROM TEMPERATURAS');
        res.json({stations:stations.rows});
    }catch (error) {
        res.status(500).json({error : error.message});
    }
})


//POST buscar informacion de la estacion
router.post('est:cod/stations',authenticationToken,async(req,res) => {
    try {
        var cod = parseInt(req.params.cod);
    } catch(error){
        res.status(500).json({error : error.message});
    }
})


//GET Busca la informacion de la estacion referenciada
router.get('/stations',authenticationToken,async(req, res) => {
    try {
        const stations = await pool.query('SELECT DISTINCT ON (ESTACION) ESTACION FROM TEMPERATURAS');
        res.json({stations:stations.rows});
    }catch (error) {
        res.status(500).json({error : error.message});
    }
})


//GET Estimate
router.get('/stations',authenticationToken,async(req, res) => {
    try {
        const stations = await pool.query('SELECT DISTINCT ON (ESTACION) ESTACION FROM TEMPERATURAS');
        res.json({stations:stations.rows});
    }catch (error) {
        res.status(500).json({error : error.message});
    }
})


export default router;