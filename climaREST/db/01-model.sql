BEGIN TRANSACTION;

DROP TABLE IF EXISTS ESTACIONES_CLIMATOLOGICAS CASCADE;
DROP TABLE IF EXISTS USUARIOS;

CREATE TABLE ESTACIONES_CLIMATOLOGICAS (
		COD_ESTACION int NOT NULL,
		NOMBRE char(90) NOT NULL,
		LATITUD char(30) NOT NULL,
		LONGITUD char(30) NOT NULL,
		ALTURA_MAR int NOT NULL,
	CONSTRAINT PK_ESTACIONES_CLIMATOLOGICAS PRIMARY KEY (COD_ESTACION)
);

CREATE TABLE TEMPERATURAS (
        COD_TEMP int NOT NULL,
        COD_ESTACION int,
        FECHA_REGISTRO char(10),
        FECHA_CREACION char(10),
        FECHA_MODIFICACION char(10),
        PRECIPITACION float,
        TEMP_MIN float,
        TEMP_MAX float,
    CONSTRAINT PK_TEMPERATURAS PRIMARY KEY (COD_TEMP),
    CONSTRAINT FK_ESTACIONES_CLIMATOLOGICAS
        FOREIGN KEY(COD_ESTACION)
            REFERENCES ESTACIONES_CLIMATOLOGICAS(COD_ESTACION)
);

CREATE TABLE USUARIOS (
        COD_RUT int NOT NULL,
        PASS char(20) NOT NULL,
        TOKEN varchar(255) NOT NULL,
        UNIQUE (TOKEN),
    CONSTRAINT PK_USUARIOS PRIMARY KEY (COD_RUT)
);