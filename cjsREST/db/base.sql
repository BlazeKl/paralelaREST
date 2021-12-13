
DROP TABLE IF EXISTS ESTACIONES CASCADE;
DROP TABLE IF EXISTS TEMPERATURAS CASCADE;
DROP TABLE IF EXISTS USUARIOS;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE ESTACIONES (
	COD_ESTACION INT NOT NULL,
	NOMBRE TEXT NOT NULL,
	LATITUD FLOAT NOT NULL,
	LONGITUD FLOAT NOT NULL,
        ALTITUD FLOAT NOT NULL,
        CONSTRAINT PK_ESTACIONES PRIMARY KEY (COD_ESTACION)
);

CREATE TABLE USUARIOS (
        ID uuid DEFAULT uuid_generate_v4(),
        EMAIL TEXT NOT NULL UNIQUE,
        PASS TEXT NOT NULL,
        CONSTRAINT PK_USUARIOS PRIMARY KEY (ID)
);

CREATE TABLE TEMPERATURAS (
        FECHA_CREADO TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        COD_ESTACION INT NOT NULL,
        PRECIPITACION TEXT,
        TEMP_MIN TEXT,
        TEMP_MAX TEXT,
        CONSTRAINT PK_TEMPERATURAS PRIMARY KEY (FECHA_CREADO),
        CONSTRAINT FK_ESTACIONES FOREIGN KEY (COD_ESTACION) REFERENCES ESTACIONES(COD_ESTACION)
);


INSERT INTO USUARIOS (EMAIL,PASS) VALUES ('felipe.perezc@utem.cl','$2b$10$yzcBQ6byb8jpVc.DGSCJKOmz8EtN/HuhLTVk.g5VIVI1d2ZLyYRm.');

INSERT INTO ESTACIONES (COD_ESTACION,NOMBRE,LATITUD,LONGITUD,ALTITUD) VALUES
(180005,' Chacalluta, Arica Ap. ',-18.35555,-70.34028,50),
(200006,' Diego Aracena Iquique Ap. ',-20.54917,-70.18111,48),
(220002,' El Loa, Calama Ad. ',-22.49806,-68.89250,2321),
(230001,' Cerro Moreno Antofagasta Ap. ',-23.45361,-70.44528,112),
(270001,' Mataveri Isla de Pascua Ap. ',-27.15889,-109.43250,44),
(270008,' Desierto de Atacama, Caldera Ad. ',-27.25444,-70.78111,197),
(290004,' La Florida, La Serena Ad. ',-29.91444,-71.20667,137),
(320041,' Viña del Mar Ad. (Torquemada) ',-32.94944,-71.47611,141),
(320051,' Los Libertadores ',-32.84555,-70.11917,2955),
(330007,' Rodelillo, Ad. ',33.06528,-71.55639,650),
(330019,' Eulogio Sánchez, Tobalaba Ad. ',-33.45528,-70.54861,650),
(330020,' Quinta Normal, Santiago ',-33.44500,-70.68278,520),
(330021,' Pudahuel Santiago ',-33.37833,-70.78778,482),
(330030,' Santo Domingo, Ad. ',-33.65611,-71.61333,77),
(330031,' Juan Fernández, Estación Meteorológica. ',-33.63583,-78.83305,40),
(330066,' La Punta, Juan Fernández Ad. ',-33.66639,-78.93167,126),
(330077,' El Colorado ',-33.35000,-70.29361,2750),
(330111,' Lo Prado Cerro San Francisco ',-33.45806,-70.94861,1068),
(330112,' San José Guayacán ',-33.61528,-70.35055,928),
(330113,' El Paico ',-33.70639,-71.00805,275),
(340031,' General Freire, Curicó Ad. ',-34.96944,-71.21694,229),
(360011,' General Bernardo O`Higgins, Chillán Ad. ',-36.58583,-72.03667,155),
(360019,' Carriel Sur, Concepción Ap. ',-36.78055,-73.06639,13),
(360042,' Termas de Chillán ',-36.90361,-71.41000,1708),
(370033,' María Dolores, Los Angeles Ad. ',-37.39694,-72.42389,118),
(380029,' La Araucanía Ad. ',-38.93444,-72.65333,96),
(390006,' Pichoy, Valdivia Ad. ',-39.65667,-73.08722,18),
(400009,' Cañal Bajo, Osorno Ad. ',-40.61444,-73.05750,61),
(410005,' El Tepual Puerto Montt Ap. ',-41.44750,-73.09583,87),
(420004,' Chaitén, Ad. ',-42.93028,-72.70083,10),
(420014,' Mocopulli Ad. ',-42.34667,-73.71500,174),
(430002,' Futaleufú Ad. ',-43.18889,-71.85222,347),
(430004,' Alto Palena Ad. ',-43.61167,-71.80139,256),
(430009,' Melinka Ad. ',-43.89778,-73.73944,8),
(450001,' Puerto Aysén Ad. ',-45.39944,-72.67722,11),
(450004,' Teniente Vidal, Coyhaique Ad. ',-45.59083,-72.10222,69),
(450005,' Balmaceda Ad. ',-45.91833,-71.67778,517),
(460001,' Chile Chico Ad. ',-46.58500,-71.68528,311),
(470001,' Lord Cochrane Ad. ',-47.24389,-72.58250,209),
(510005,' Teniente Gallardo, Puerto Natales Ad. ',-51.66722,-72.52889,69),
(520006,' Carlos Ibañez, Punta Arenas Ap. ',-53.00167,-70.83861,36),
(530005,' Fuentes Martínez, Porvenir Ad. ',-53.25361,-70.32611,25),
(550001,' Guardiamarina Zañartu, Pto Williams Ad. ',-54.93167,-67.61556,12),
(950001,' C.M.A. Eduardo Frei Montalva, Antártica ',-62.19194,-58.97972,45),
(950002,' Arturo Prat, Base Antártica ',-62.47861,-59.66417,5),
(950003,' Bernardo O`Higgins, Base Antártica ',-63.32083,-57.89944,10);