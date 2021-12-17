import express from 'express';
import pool from './connect.js';
import moment from 'moment';
import { authenticationToken } from '../middleware/authmid.js';

const router = express.Router();

//GET retorna el nombre de las estaciones
router.get('/stations',authenticationToken,async(req, res) => {
    try {
        const station = await pool.query('SELECT * FROM ESTACIONES');
        console.log('Request a /stations')
        res.json(station.rows);
    }catch (error) {
        res.status(500).json({error : error.message});
    }
})


//buscar informacion de la estacion
router.get('/:cod/stations',authenticationToken,async(req,res) => {
    try {
        let isnum = /^\d+$/.test(val);
        if (isnum){
            var cod = parseInt(req.params.cod);
            const info = await pool.query('SELECT * FROM ESTACIONES WHERE COD_ESTACION = $1',[cod]);
            res.json(info.rows);
        } else {
            return res.status(500).json({error:"invalid"});
        }
    } catch(error){
        res.status(500).json({error : error.message});
    }
})


//POST Busca la informacion de la estacion referenciada
router.post('/search',authenticationToken,async(req, res) => {
    try {
        const {indicador,desde,hasta} = req.body;
        var dformat = "YYYY-MM-DD";
        if (moment(desde,dformat, true).isValid() && moment(hasta,dformat, true).isValid()){
            if (indicador == "1"){ //MAX
                const info = await pool.query('SELECT FECHA_CREADO,TEMP_MAX FROM TEMPERATURAS WHERE FECHA_CREADO >= $1 AND FECHA_CREADO <= $2',[desde,hasta]);
                res.json(info.rows);
            } else if (indicador == "2"){ //MIN
                const info = await pool.query('SELECT FECHA_CREADO,TEMP_MIN FROM TEMPERATURAS WHERE FECHA_CREADO >= $1 AND FECHA_CREADO <= $2',[desde,hasta]);
                res.json(info.rows);
            } else if (indicador == "3"){ //AGUA
                const info = await pool.query('SELECT FECHA_CREADO,PRECIPITACION FROM TEMPERATURAS WHERE FECHA_CREADO >= $1 AND FECHA_CREADO <= $2',[desde,hasta]);
                res.json(info.rows);
            } else {
                return res.status(500).json({error: "Invalid Operation"});
            }
        } else {
            return res.status(500).json({error: "Invalid Operation"});
        }
        
    }catch (error) {
        res.status(500).json({error : error.message});
    }
})


//GET Estimate
router.get('/:latitud/:longitud/estimate',authenticationToken,async(req, res) => {
    try {
        const data = await pool.query('SELECT * FROM ESTACIONES');
        var lat = parseFloat(req.params.latitud);
        var lon = parseFloat(req.params.longitud);
        var aux = 0, dist, cod_estacion;
        for (let i = 0 ; i < data.rows.length ; i++){
            dist = Math.sqrt((Math.pow(data.rows[i].latitud-lat,2)) + (Math.pow(data.rows[i].longitud-lon,2)));
            if (aux == 0){
                aux = dist;
                cod_estacion = data.rows[i].cod_estacion;
            }else if (dist <= aux){
                aux = dist;
                cod_estacion = data.rows[i].cod_estacion;
            }
        }
        console.log('Estimacion tomada por estacion:', cod_estacion);
        const station = await pool.query('SELECT TEMP_MAX,TEMP_MIN,PRECIPITACION FROM TEMPERATURAS WHERE COD_ESTACION = $1 ORDER BY FECHA_CREADO DESC LIMIT 1',[cod_estacion]);
        res.json(station.rows[0]);

    }catch (error) {
        res.status(500).json({error : error.message});
    }
})


export default router;