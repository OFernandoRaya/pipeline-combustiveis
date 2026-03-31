create table combustiveis.silver_preco_petroleo
with (
    format = 'PARQUET',
    external_location = 's3://data-lake-combustiveis/silver/preco_petroleo/'
) as
select

    concat(
        concat('20', split(data,' ')[2]),
        '-',
        case substr(data,1,3)
            when 'Jan' then '01'
            when 'Fev' then '02'
            when 'Mar' then '03'
            when 'Abr' then '04'
            when 'Mai' then '05'
            when 'Jun' then '06'
            when 'Jul' then '07'
            when 'Ago' then '08'
            when 'Set' then '09'
            when 'Out' then '10'
            when 'Nov' then '11'
            when 'Dez' then '12'
        end
    ) as data,

    try_cast(replace(ultimo, ',', '.') as double) as ultimo,
    try_cast(replace(abertura, ',', '.') as double) as abertura,
    try_cast(replace(maxima, ',', '.') as double) as maxima,
    try_cast(replace(minima, ',', '.') as double) as minima,

    case
        when volume like '%M' then
            cast(replace(replace(volume,'M',''),',','.') as double) * 1000000
        when volume like '%K' then
            cast(replace(replace(volume,'K',''),',','.') as double) * 1000
        else
            cast(replace(volume,',','.') as double)
    end as volume_tratado,

    cast(
        replace(
            replace(variacao, '%', ''),
            ',', '.'
        ) as double
    ) as variacao,

    date_format(current_timestamp, '%Y-%m-%d %H:%i:%s') as ingest_timestamp

from combustiveis.bronze_preco_petroleo