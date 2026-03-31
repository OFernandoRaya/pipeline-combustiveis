CREATE TABLE combustiveis.gold_fact_precos_combustiveis_mensal
WITH (
    format = 'PARQUET',
    external_location = 's3://data-lake-combustiveis/gold/precos_combustiveis_mensal/'
) AS

WITH base AS (
    SELECT
        try(date_parse(concat(mes, '-01'), '%Y-%m-%d')) AS data_convertida,

        produto,
        regiao,
        numero_postos_pesquisados,
        preco_medio_revenda,
        desvio_padrao_revenda,
        preco_minimo_revenda,
        preco_maximo_revenda,
        margem_media_revenda,
        coef_variacao_revenda,
        preco_medio_distribuicao

    FROM combustiveis.silver_preco_gasolina
)

SELECT
    row_number() over () AS preco_id,

    date_trunc('month', data_convertida) AS data_mes,
    year(data_convertida) AS ano,
    month(data_convertida) AS mes,

    CASE month(data_convertida)
        WHEN 1 THEN 'Janeiro'
        WHEN 2 THEN 'Fevereiro'
        WHEN 3 THEN 'Março'
        WHEN 4 THEN 'Abril'
        WHEN 5 THEN 'Maio'
        WHEN 6 THEN 'Junho'
        WHEN 7 THEN 'Julho'
        WHEN 8 THEN 'Agosto'
        WHEN 9 THEN 'Setembro'
        WHEN 10 THEN 'Outubro'
        WHEN 11 THEN 'Novembro'
        WHEN 12 THEN 'Dezembro'
    END AS mes_nome,

    regiao,
    produto,
    preco_medio_revenda,
    desvio_padrao_revenda,
    preco_minimo_revenda,
    preco_maximo_revenda,
    margem_media_revenda,
    coef_variacao_revenda,
    preco_medio_distribuicao,
    numero_postos_pesquisados,

    CASE 
        WHEN year(data_convertida) <= 2012 THEN '2001-2012'
        ELSE '2013-2019'
    END AS fonte_periodo

FROM base

WHERE data_convertida IS NOT NULL;