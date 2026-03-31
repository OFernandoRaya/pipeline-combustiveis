create table combustiveis.silver_preco_dolar
with (
    format = 'PARQUET',
    external_location = 's3://data-lake-combustiveis/silver/preco_dolar/'
) as
select
    --Conversão da coluna de data para YYYY-MM
    case
        when regexp_like("data", '^[0-9]{2}/[0-9]{2}/[0-9]{4}$') then concat(substr("data",7,4), '-', substr("data",4,2))
        when regexp_like("data", '^[A-Za-z]{3} [0-9]{1,2}$') then
            concat(
                case 
                    when length(trim(split("data",' ')[2]))=1 then concat('200',trim(split("data",' ')[2]))
                    when length(trim(split("data",' ')[2]))=2 then concat('20',trim(split("data",' ')[2]))
                end,
                '-',
                case 
                    when substr("data",1,3)='Jan' then '01'
                    when substr("data",1,3)='Fev' then '02'
                    when substr("data",1,3)='Mar' then '03'
                    when substr("data",1,3)='Abr' then '04'
                    when substr("data",1,3)='Mai' then '05'
                    when substr("data",1,3)='Jun' then '06'
                    when substr("data",1,3)='Jul' then '07'
                    when substr("data",1,3)='Ago' then '08'
                    when substr("data",1,3)='Set' then '09'
                    when substr("data",1,3)='Out' then '10'
                    when substr("data",1,3)='Nov' then '11'
                    when substr("data",1,3)='Dez' then '12'
                end
            )
        else null
    end as data,

    --Conversão de números
    cast(replace(abertura, ',', '.') as double) as abertura,
    cast(replace(maximo, ',', '.') as double) as maximo,
    cast(replace(minimo, ',', '.') as double) as minimo,
    cast(replace(fechamento, ',', '.') as double) as fechamento,
    cast(replace(replace(variacao, ',', '.'), '%', '') as double) as variacao,

    date_format(current_timestamp, '%Y-%m-%d %H:%i:%s') as ingest_timestamp

from combustiveis.bronze_preco_dolar;