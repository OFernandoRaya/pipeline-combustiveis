CREATE TABLE combustiveis.gold_fact_preco_petroleo_mensal
WITH (
    format = 'PARQUET',
    external_location = 's3://data-lake-combustiveis/gold/preco_petroleo_mensal/'
) AS

WITH base AS (
    SELECT
        date_parse(concat(data, '-01'), '%Y-%m-%d') AS data_convertida,
        ultimo,
        abertura,
        maxima,
        minima,
        variacao
    FROM combustiveis.silver_preco_petroleo
)

SELECT
    date_trunc('month', data_convertida) AS data_mes,
    year(data_convertida) AS ano,
    month(data_convertida) AS mes,
    ultimo AS preco_fechamento_usd,
    abertura AS preco_abertura_usd,
    maxima AS preco_maximo_usd,
    minima AS preco_minimo_usd,
    variacao AS variacao_percentual
FROM base;