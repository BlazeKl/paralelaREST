import express from 'express';
import pool from './connect.js';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import {jwtTokens} from '../tools/ahelper.js'

const router = express.Router();

router.post('/', async (req,res) => {
    try {
        const {email,password} = req.body;
        //validar email aqui
        if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email))
        {
            const users = await pool.query(
                'SELECT * FROM USUARIOS WHERE EMAIL = $1',
                [email]);

            if (users.rows.length === 0) return res.status(401).json({error : "Login incorrecto (email)"});
            
            const is_valid = await bcrypt.compare(password, users.rows[0].pass);
            if(!is_valid) return res.status(401).json({error:"Login incorrecto (pass)"});

            let tokens = jwtTokens(users.rows[0]);
            res.cookie('rtoken', tokens.rtoken,{httpOnly:true});
            res.json(tokens);

            
        } else 
        {
            return res.status(401).json({error:"Login incorrecto (invalid))"});
        }
    } catch (error) {
        res.status(401).json({error:error.message});
    }
})

router.get('/refresh',(req,res) =>{
    try {
        const rtoken = req.cookies.rtoken;
        if(rtoken === null) return res.status(401).json({error:"Error Token"});
        jwt.verify(rtoken,process.env.REFRESH_TOKEN_SECRET,(error,user) =>{
            if(error) return res.status(403).json({error:error.message});
            let tokens = jwtTokens(user);
            res.cookie('rtoken', tokens.rtoken,{httpOnly:true});
            res.json(tokens);
        })
    } catch(error){
        res.status(401).json({error:error.message});
    }
})

router.delete('/refresh',(req,res) =>{
    try {
        res.clearCookie('rtoken');
        return res.status(200).json({message:'rtoken eliminado'});
    } catch(error){
        res.status(401).json({error:error.message});
    }
})

export default router;