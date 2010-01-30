CREATE UNIQUE INDEX IF NOT EXISTS
    tbl_padron_cedula ON tbl_padron (
        cedula
    );

CREATE INDEX IF NOT EXISTS
    tbl_padron_nombre_pape_sape ON tbl_padron (
        nombre,
        pape,
        sape
    );

CREATE INDEX IF NOT EXISTS
    tbl_padron_nombre_pape ON tbl_padron (
        nombre,
        pape
    );

CREATE INDEX IF NOT EXISTS
    tbl_padron_pape_sape ON tbl_padron (
        pape,
        sape
    );

CREATE UNIQUE INDEX IF NOT EXISTS
    tbl_codele_completo_lugar ON tbl_codele_completo (
        cod_provincia,
        cod_canton,
        cod_dist_elec
    );

CREATE INDEX IF NOT EXISTS
    tbl_juntas_lugar ON tbl_juntas (
        cod_provincia,
        cod_canton,
        cod_dist_elec
    );

CREATE UNIQUE INDEX IF NOT EXISTS
    tbl_juntas_num_junta ON tbl_juntas (
        num_junta
    );

CREATE INDEX IF NOT EXISTS
    tbl_padron_num_junta ON tbl_padron (
        num_junta
    );

CREATE INDEX IF NOT EXISTS
    tbl_centros_votacion_junta ON tbl_centros_votacion (
        junta
    );
