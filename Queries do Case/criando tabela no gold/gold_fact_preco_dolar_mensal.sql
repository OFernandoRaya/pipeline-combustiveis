CREATE TABLE combustiveis.gold_fact_preco_dolar_mensal
WITH (
    format = 'PARQUET',
    external_location = 's3://data-lake-combustiveis/gold/preco_dolar_mensal/'
) AS

WITH base AS (
    SELECT
        date_parse(concat(data, '-01'), '%Y-%m-%d') AS data_convertida,
        fechamento,
        abertura,
        maximo,
        minimo,
        variacao
    FROM combustiveis.silver_preco_dolar
)

SELECT
    date_trunc('month', data_convertida) AS data_mes,
    year(data_convertida) AS ano,
    month(data_convertida) AS mes,
    fechamento AS preco_fechamento,
    abertura AS preco_abertura,
    maximo AS preco_maximo,
    minimo AS preco_minimo,
    variacao AS variacao_percentual
FROM base;