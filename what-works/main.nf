// include { fromQuery } from 'plugin/nf-sqldb'

// channel.fromQuery('select alpha, delta, omega from SAMPLE', db: 'foo').view()
include { sqlInsert } from 'plugin/nf-sqldb'

channel
    .of('Hello','world!')
    .map( it -> tuple(it, it.length()) )
    .sqlInsert( into: 'SAMPLE', columns: 'NAME, LEN', db: 'foo', setup: 'CREATE TABLE SAMPLE(NAME VARCHAR, LEN INTEGER);' )
