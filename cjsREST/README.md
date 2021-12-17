# cjsREST

API REST de informacion meteorologica desarrollada en javascript por nodejs y express.
Consumir informacion de base de datos PostgreSQL,

## DB postgre
query de creacion por
```
./db/base.sql
```

## Run
Instalar dependencias necesarias para correr la API
```
npm install
```

Correr con debugging
```
npm install nodemon
npm run debug
```

Correr sin debugging
```
npm rum normal
```

## Consideraciones 

Todos los dias a la hora 13;00 del sistema operativo, se realizara webscrapping con informacion meteorologica del dia, de no estar corriendo en la hora especificada, no se realizara el webscrapping hasta el siguiente dia.
