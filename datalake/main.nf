link = "s3://blah/blah.csv"
workflow poorman {
    DuckDB("""
           set s3_access_key_id='test';
           set s3_secret_access_key='test';
           set s3_endpoint='localhost:4566';
           set s3_use_ssl='false';
           set s3_url_style='path';

           -- display tables
           SHOW tables;
           """
    )
    DUCKDB_S3(link)
    DUCKDB_NATIVE()

}
DUCKDB_S3

process DUCKDB {

    input:
    val query


    script:

    """
    duckdb :memory: "$query"
    """

}
