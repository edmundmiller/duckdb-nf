include { fromQuery } from 'plugin/nf-sqldb'

channel.fromQuery('select alpha, delta, omega from SAMPLE', db: 'foo').view()
