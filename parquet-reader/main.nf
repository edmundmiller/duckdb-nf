include { fromQuery } from 'plugin/nf-sqldb'

channel
    .fromQuery(
        "select arr_delay from read_parquet('flights.parquet');",
        db: 'flights'
    ) | view