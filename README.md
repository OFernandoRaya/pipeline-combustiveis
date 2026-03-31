# Pipeline Analítico de Combustíveis no Brasil
📌 **Visão Geral**

Este projeto implementa um pipeline de dados na AWS para análise de preços de combustíveis no Brasil, integrando informações de gasolina, etanol, diesel, dólar e petróleo.
O objetivo é transformar dados brutos em uma camada analítica (Gold) pronta para insights, como a paridade entre etanol e gasolina e o impacto de variáveis macroeconômicas.

🏗️ **Arquitetura**

Data Lake: Amazon S3
Processamento: Amazon Athena (SQL)
Camadas de dados:
Raw: dados brutos sem alterações
Silver: dados tratados, padronizados e validados
Gold: dados consolidados para análise

🔄 **Pipeline de Dados**

Ingestão de dados brutos no S3
Transformações e padronizações na camada Silver
Consolidação e métricas na camada Gold
Disponibilização para análise e consumo (BI ou SQL)

🧠 **Modelagem**

A tabela final foi construída com:
Junção de múltiplas fontes (combustíveis, dólar, petróleo e produção)
Padronização temporal mensal
Normalização de dados de produção usando UNNEST
Criação de métricas analíticas para fácil interpretação

📊 **Métricas Criadas**

Paridade Etanol/Gasolina
Preço do Petróleo em BRL
Impacto do Dólar
Produção mensal de etanol

⚠️ **Desafios Enfrentados**

Padronização de datas entre diferentes fontes
Conflitos de tipos (timestamp vs varchar)
Joins com formatos incompatíveis
Normalização de colunas mensais via UNNEST
Performance de consultas no Athena

📈 **Possíveis Evoluções**
Particionamento da tabela por data para otimizar consultas
Integração com Power BI ou QuickSight
Automatização do pipeline com AWS Glue ou Airflow
Criação de dashboards analíticos interativos
