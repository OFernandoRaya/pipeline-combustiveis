CREATE TABLE combustiveis.gold_fact_producao_etanol_anidro_mensal
WITH (
    format = 'PARQUET',
    external_location = 's3://data-lake-combustiveis/gold/producao_etanol_anidro_mensal/'
) AS

SELECT
    CAST(ano AS INTEGER) AS ano,
    regiao,
    estado,

    CAST(replace(NULLIF(jan, ''), ',', '.') AS DOUBLE) AS producao_jan,
    CAST(replace(NULLIF(fev, ''), ',', '.') AS DOUBLE) AS producao_fev,
    CAST(replace(NULLIF(mar, ''), ',', '.') AS DOUBLE) AS producao_mar,
    CAST(replace(NULLIF(abr, ''), ',', '.') AS DOUBLE) AS producao_abr,
    CAST(replace(NULLIF(mai, ''), ',', '.') AS DOUBLE) AS producao_mai,
    CAST(replace(NULLIF(jun, ''), ',', '.') AS DOUBLE) AS producao_jun,
    CAST(replace(NULLIF(jul, ''), ',', '.') AS DOUBLE) AS producao_jul,
    CAST(replace(NULLIF(ago, ''), ',', '.') AS DOUBLE) AS producao_ago,
    CAST(replace(NULLIF(sep, ''), ',', '.') AS DOUBLE) AS producao_set,
    CAST(replace(NULLIF(oct, ''), ',', '.') AS DOUBLE) AS producao_out,
    CAST(replace(NULLIF(nov, ''), ',', '.') AS DOUBLE) AS producao_nov,
    CAST(replace(NULLIF(dez, ''), ',', '.') AS DOUBLE) AS producao_dez,

    (
        COALESCE(CAST(replace(NULLIF(jan, ''), ',', '.') AS DOUBLE), 0) +
        COALESCE(CAST(replace(NULLIF(fev, ''), ',', '.') AS DOUBLE), 0) +
        COALESCE(CAST(replace(NULLIF(mar, ''), ',', '.') AS DOUBLE), 0) +
        COALESCE(CAST(replace(NULLIF(abr, ''), ',', '.') AS DOUBLE), 0) +
        COALESCE(CAST(replace(NULLIF(mai, ''), ',', '.') AS DOUBLE), 0) +
        COALESCE(CAST(replace(NULLIF(jun, ''), ',', '.') AS DOUBLE), 0) +
        COALESCE(CAST(replace(NULLIF(jul, ''), ',', '.') AS DOUBLE), 0) +
        COALESCE(CAST(replace(NULLIF(ago, ''), ',', '.') AS DOUBLE), 0) +
        COALESCE(CAST(replace(NULLIF(sep, ''), ',', '.') AS DOUBLE), 0) +
        COALESCE(CAST(replace(NULLIF(oct, ''), ',', '.') AS DOUBLE), 0) +
        COALESCE(CAST(replace(NULLIF(nov, ''), ',', '.') AS DOUBLE), 0) +
        COALESCE(CAST(replace(NULLIF(dez, ''), ',', '.') AS DOUBLE), 0)
    ) AS producao_total_anual

FROM combustiveis.bronze_producao_etanol;