create table combustiveis.silver_preco_gasolina
with (
    format = 'PARQUET',
    external_location = 's3://data-lake-combustiveis/silver/preco_gasolina/'
) as
select

    concat(substr(mes,7,4), '-', substr(mes,4,2)) as mes,

    produto,
    regiao,

    try_cast(numero_postos_pesquisados as integer) as numero_postos_pesquisados,
    unidade_medida,

    try_cast(replace(preco_medio_revenda, ',', '.') as double) as preco_medio_revenda,
    try_cast(replace(desvio_padrao_revenda, ',', '.') as double) as desvio_padrao_revenda,
    try_cast(replace(preco_minimo_revenda, ',', '.') as double) as preco_minimo_revenda,
    try_cast(replace(preco_maximo_revenda, ',', '.') as double) as preco_maximo_revenda,
    try_cast(replace(margem_media_revenda, ',', '.') as double) as margem_media_revenda,
    try_cast(replace(coef_variacao_revenda, ',', '.') as double) as coef_variacao_revenda,

    try_cast(replace(preco_medio_distribuicao, ',', '.') as double) as preco_medio_distribuicao,
    try_cast(replace(desvio_padrao_distribuicao, ',', '.') as double) as desvio_padrao_distribuicao,
    try_cast(replace(preco_minimo_distribuicao, ',', '.') as double) as preco_minimo_distribuicao,
    try_cast(replace(preco_maximo_distribuicao, ',', '.') as double) as preco_maximo_distribuicao,
    try_cast(replace(coef_variacao_distribuicao, ',', '.') as double) as coef_variacao_distribuicao,

    cast(current_timestamp as timestamp) as ingest_timestamp

from combustiveis.bronze_preco_gasolina
where mes != 'MÊS'
and mes is not null;