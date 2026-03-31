create external table combustiveis.bronze_preco_petroleo (
	data string,
	ultimo string,
	abertura string,
	maxima string,
	minima string,
	volume string,
	variacao string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	"separatorChar" = ",",
	"quoteChar" = "\""
)
LOCATION 's3://data-lake-combustiveis/bronze/preco_petroleo/'
TBLPROPERTIES ("skip.header.line.count" = "1");
