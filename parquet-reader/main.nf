include { fromQuery } from 'plugin/nf-sqldb'

channel
    .fromQuery("select Z_noise from read_parquet('area1.parquet')", db: 'flights')
| view