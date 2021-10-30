import express,{json} from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import cookieParser from 'cookie-parser';
import {dirname,join} from 'path';
import {fileURLToPath} from 'url';

dotenv.config();

const __dirname = dirname(fileURLToPath(import.meta.url));

const app = express();
const port = process.env.PORT || 3000;
const corsOptions = {credentials:true, origin: process.env.URL || '*'}

app.use(cors(corsOptions));
app.use(json());
app.use(cookieParser());

app.get('/', (request, response) => {
    response.json({ info: 'API REST clima' })
  })

app.listen(port, () => {
  console.log(`App running on port ${port}.`)
})