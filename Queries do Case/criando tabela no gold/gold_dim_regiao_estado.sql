CREATE TABLE combustiveis.gold_dim_regiao_estado
WITH (
    format = 'PARQUET',
    external_location = 's3://data-lake-combustiveis/gold/dim_regiao_estado/'
) AS

SELECT
    row_number() over () as id,
    regiao,
    estado_id,
    estado
FROM (
    VALUES
        ('NORTE', 'AC', 'Acre'),
        ('NORTE', 'AP', 'Amapá'),
        ('NORTE', 'AM', 'Amazonas'),
        ('NORTE', 'PA', 'Pará'),
        ('NORTE', 'RO', 'Rondônia'),
        ('NORTE', 'RR', 'Roraima'),
        ('NORTE', 'TO', 'Tocantins'),

        ('NORDESTE', 'AL', 'Alagoas'),
        ('NORDESTE', 'BA', 'Bahia'),
        ('NORDESTE', 'CE', 'Ceará'),
        ('NORDESTE', 'MA', 'Maranhão'),
        ('NORDESTE', 'PB', 'Paraíba'),
        ('NORDESTE', 'PE', 'Pernambuco'),
        ('NORDESTE', 'PI', 'Piauí'),
        ('NORDESTE', 'RN', 'Rio Grande do Norte'),
        ('NORDESTE', 'SE', 'Sergipe'),

        ('CENTRO-OESTE', 'DF', 'Distrito Federal'),
        ('CENTRO-OESTE', 'GO', 'Goiás'),
        ('CENTRO-OESTE', 'MT', 'Mato Grosso'),
        ('CENTRO-OESTE', 'MS', 'Mato Grosso do Sul'),

        ('SUDESTE', 'ES', 'Espírito Santo'),
        ('SUDESTE', 'MG', 'Minas Gerais'),
        ('SUDESTE', 'RJ', 'Rio de Janeiro'),
        ('SUDESTE', 'SP', 'São Paulo'),

        ('SUL', 'PR', 'Paraná'),
        ('SUL', 'RS', 'Rio Grande do Sul'),
        ('SUL', 'SC', 'Santa Catarina')
) AS t(regiao, estado_id, estado);