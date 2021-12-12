import express,{json} from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import cookieParser from 'cookie-parser';
import {dirname,join} from 'path';
import {fileURLToPath} from 'url';
import usersRouter from './src/user.js';
import authRouter from './src/auth.js';
import restRouter from './src/rest.js'
import { webscrap } from './src/webscrap.js';
import { Injectable, Logger } from '@nestjs/common';

dotenv.config();

const __dirname = dirname(fileURLToPath(import.meta.url));

const app = express();
const port = process.env.PORT || 3000;
const corsOptions = {credentials:true, origin: process.env.URL || '*'};

//webscrap();

app.use(cors(corsOptions));
app.use(json());
app.use(cookieParser());

app.get('/', (request, response) => {
    response.json({ info: 'API REST clima' })
  });
  
app.use('/grupo-a/usuarios',usersRouter);
app.use('/grupo-a/login',authRouter);
app.use('/grupo-a',restRouter)

app.listen(port, () => {
  console.log(`App running on port ${port}.`)
})
