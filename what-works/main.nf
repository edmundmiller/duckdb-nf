params.netflix = 'https://github.com/mehd-io/duckdb-playground-tutorial/raw/main/data/netflix_daily_top_10.csv'

include { fromQuery } from 'plugin/nf-sqldb'

channel
    .fromQuery("select Title from read_csv_auto('netflix_daily_top_10.csv')", db: 'foo')
    | view
