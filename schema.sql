DROP TABLE IF EXISTS TBL_CANTONES;
CREATE TABLE TBL_CANTONES
 (
        EDIV_PROVINCIA                  Numeric (2),
        EDIV_CODIGO_CANTON              Numeric (2),
        EDIV_NOMBRE_LUGAR               Text (68)
);
-- CREATE ANY INDEXES ...

DROP TABLE IF EXISTS TBL_PARAMETROS;
CREATE TABLE TBL_PARAMETROS
 (
        PARAMETRO                       Text (400),
        DESCRIPCION                     Text (400)
);
-- CREATE ANY INDEXES ...

DROP TABLE IF EXISTS TBL_PROVINCIAS;
CREATE TABLE TBL_PROVINCIAS
 (
        PROVINCIA                       Integer,
        EDIV_NOMBRE_LUGAR               Text (68)
);
-- CREATE ANY INDEXES ...

DROP TABLE IF EXISTS TBL_CENTROS_VOTACION;
CREATE TABLE TBL_CENTROS_VOTACION
 (
        JUNTA                           Numeric (3),
        DESCRIPCION                     Text (510),
        DIRECCION                       Text (510)
);

DROP TABLE IF EXISTS TBL_CENTROS_VOTACION123;
CREATE TABLE TBL_CENTROS_VOTACION123
 (
        JUNTA                           Numeric (3),
        DESCRIPCION                     Text (510),
        DIRECCION                       Text (510)
);
-- CREATE ANY INDEXES ...

DROP TABLE IF EXISTS TBL_JUNTAS;
CREATE TABLE TBL_JUNTAS
 (
        COD_PROVINCIA                   Integer,
        COD_CANTON                      Integer,
        COD_DIST_ELEC                   Integer,
        NUM_JUNTA                       Integer,
        CANT_ELECTORES                  Integer
);
-- CREATE ANY INDEXES ...

DROP TABLE IF EXISTS TBL_ADMIN_COMPLETO;
CREATE TABLE TBL_ADMIN_COMPLETO
 (
        COD_PROVINCIA                   Integer,
        COD_CANTON                      Integer,
        COD_DIST_ADMIN                  Integer,
        COD_DIST_ELEC                   Integer,
        EDIV_NOMBRE_PROVINCIA           Text (510),
        EDIV_NOMBRE_CANTON              Text (510),
        ADMINISTRATIVO                  Text (510),
        ELECTORAL                       Text (510)
);
-- CREATE ANY INDEXES ...

DROP TABLE IF EXISTS TBL_PADRON;
CREATE TABLE TBL_PADRON
 (
        CEDULA                          Text (24),
        SEXO                            Text (2),
        COD_PROVINCIA                   Numeric (17),
        COD_CANTON                      Numeric (17),
        COD_DIST_ELEC                   Numeric (17),
        FEC_CADUCIDAD                   DateTime,
        NUM_JUNTA                       Numeric (17),
        PAPE                            Text (120),
        SAPE                            Text (120),
        NOMBRE                          Text (80)
);
-- CREATE ANY INDEXES ...

DROP TABLE IF EXISTS TBL_CODELE_COMPLETO;
CREATE TABLE TBL_CODELE_COMPLETO
 (
        COD_PROVINCIA                   Integer,
        COD_CANTON                      Integer,
        COD_DIST_ELEC                   Integer,
        EDIV_NOMBRE_PROVINCIA           Text (510),
        EDIV_NOMBRE_CANTON              Text (510),
        EDIV_NOMBRE_DIST_ELEC           Text (510)
);
