import cheerio from 'cheerio';
import request from 'request';
import fs from 'fs';
import pool from './connect.js';
import { data } from 'cheerio/lib/api/attributes.js';

function webscrap_temp(){
    request('https://climatologia.meteochile.gob.cl/application/diario/boletinClimatologicoDiario/actual', (err, res, body) => {
        if (!err && res.statusCode == 200){
            let pag = cheerio.load(body);
            pag("#excel > div > table > tbody > tr").each(async (index,element) => {
                if ((index == 0) || (index == 1)) return true;
                const td = pag(element).find("td");
                let estacion = pag(td[0]).text();
                let min = pag(td[1]).text();
                let max = pag(td[3]).text();
                let awua = pag(td[5]).text();

                if ((min === ' - ') || (min === ' . ') || (min === ' S/P ')){
                    min = null;
                } else {
                    min = pag(td[1]).text();
                }

                if ((max === ' - ') || (max === '. ') || (max === ' S/P ')){
                    max = null;
                } else {
                    max = pag(td[3]).text();
                }

                if ((awua === ' - ') || (awua === ' . ') || (awua === ' S/P ')){
                    awua = 0;
                } else {
                    awua = pag(td[5]).text();
                }
                console.log("|",pag(td[0]).text().split(/\s+/).join(' '),"|", min, max, awua);
                const cestacion = await pool.query('SELECT COD_ESTACION FROM ESTACIONES WHERE NOMBRE LIKE $1',[pag(td[0]).text().replace(/\s+/g, ' ')]);
                console.log(pag(td[0]).text().replace(/\s+/g, ' '),cestacion.rows);
                pool.query('INSERT INTO TEMPERATURAS (COD_ESTACION, PRECIPITACION, TEMP_MIN, TEMP_MAX) VALUES ($1,$2,$3,$4)',[cestacion.rows[0].cod_estacion,awua,min,max])
            })
        }
    })
}

export {webscrap_temp};