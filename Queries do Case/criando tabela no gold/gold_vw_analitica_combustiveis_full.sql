CREATE TABLE combustiveis.gold_vw_analitica_combustiveis_full
WITH (
    format = 'PARQUET',
    external_location = 's3://data-lake-combustiveis/gold/vw_analitica_combustiveis_full/'
) AS

WITH precos AS (
    SELECT *
    FROM combustiveis.gold_fact_precos_combustiveis_mensal
),

gasolina AS (
    SELECT 
        date_format(data_mes, '%Y-%m') AS data_mes,
        preco_medio_revenda AS preco_gasolina
    FROM precos
    WHERE lower(produto) LIKE '%gasolina%'
),

etanol AS (
    SELECT
        date_format(data_mes, '%Y-%m') AS data_mes,
        preco_medio_revenda AS preco_etanol
    FROM precos
    WHERE lower(produto) LIKE '%etanol%'
),

diesel AS (
    SELECT
        date_format(data_mes, '%Y-%m') AS data_mes,
        preco_medio_revenda AS preco_diesel
    FROM precos
    WHERE lower(produto) LIKE '%diesel%'
),

dolar AS (
    SELECT 
        date_format(data_mes, '%Y-%m') AS data_mes,
        preco_fechamento AS dolar_fechamento,
        variacao_percentual AS variacao_dolar
    FROM combustiveis.gold_fact_preco_dolar_mensal
),

petroleo AS (
    SELECT 
        date_format(data_mes, '%Y-%m') AS data_mes,
        preco_fechamento_usd AS preco_petroleo_usd
    FROM combustiveis.gold_fact_preco_petroleo_mensal
),

producao AS (
    SELECT
        CONCAT(CAST(ano AS VARCHAR), '-', LPAD(mes, 2, '0')) AS data_mes,
        CAST(producao_mensal AS DOUBLE) AS producao_mensal
    FROM combustiveis.gold_fact_producao_etanol_anidro_mensal
    CROSS JOIN UNNEST(
        ARRAY[
            '01','02','03','04','05','06',
            '07','08','09','10','11','12'
        ],
        ARRAY[
            producao_jan, producao_fev, producao_mar, producao_abr,
            producao_mai, producao_jun, producao_jul, producao_ago,
            producao_set, producao_out, producao_nov, producao_dez
        ]
    ) AS t(mes, producao_mensal)
)

SELECT
    g.data_mes,
    g.preco_gasolina,
    e.preco_etanol,
    d.preco_diesel,
    dol.dolar_fechamento,
    p.preco_petroleo_usd,
    (p.preco_petroleo_usd * dol.dolar_fechamento) AS preco_petroleo_brl,
    (e.preco_etanol / (g.preco_gasolina * 0.70)) AS paridade_etanol_gasolina,
    dol.variacao_dolar AS impacto_dolar,
    prod.producao_mensal

FROM gasolina g
LEFT JOIN etanol e ON g.data_mes = e.data_mes
LEFT JOIN diesel d ON g.data_mes = d.data_mes
LEFT JOIN dolar dol ON g.data_mes = dol.data_mes
LEFT JOIN petroleo p ON g.data_mes = p.data_mes
LEFT JOIN producao prod ON g.data_mes = prod.data_mes;