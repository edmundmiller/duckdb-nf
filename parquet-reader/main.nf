flights = file("https://raw.githubusercontent.com/mehd-io/duckdb-playground-tutorial/main/data/netflix_daily_top_10.parquet", checkExists: true )

include { fromQuery } from 'plugin/nf-sqldb'

channel
    .fromQuery(
        "select arr_delay from read_parquet('${flights}');",
        db: 'flights'
    ) | view
