import cheerio from 'cheerio';
import request from 'request';
import fs from 'fs';
import pool from './connect.js';
import { data } from 'cheerio/lib/api/attributes.js';

function webscrap_temp(){
    request('https://climatologia.meteochile.gob.cl/application/diario/boletinClimatologicoDiario/actual', (err, res, body) => {
        if (!err && res.statusCode == 200){
            let pag = cheerio.load(body);
            pag("#excel > div > table > tbody > tr").each((index,element) => {
                if ((index == 0) || (index == 1)) return true;
                const td = pag(element).find("td");
                let estacion = pag(td[0]).text();
                let min = pag(td[1]).text();
                let max = pag(td[3]).text();
                let awua = pag(td[6]).text();

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
                    awua = null;
                } else {
                    awua = pag(td[6]).text();
                }
                console.log(pag(td[0]).text(), min, max, awua);
                pool.query('INSERT INTO TEMPERATURAS (ESTACION, PRECIPITACION, TEMP_MIN, TEMP_MAX) VALUES ($1,$2,$3,$4)',[estacion,awua,min,max])
            })
        }
    })
}

export {webscrap_temp};