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
    DUCKDB_NATIVE(file(link))
}

// Let DuckDB Read from s3
process DUCKDB_S3 {

    input:
    val link // s3://blah/blah.csv

    script:
    """
    duckdb "SELECT * FROM read_csv('$link', filename=true);"
    """
}

// Stage the file for DuckDB with Nextflow
process DUCKDB_NATIVE {

    input:
    path csv // blah.csv

    script:
    """
    duckdb "SELECT * FROM read_csv('$csv', filename=true);"
    """
}

process DUCKDB {

    input:
    val query


    script:

    """
    duckdb :memory: "$query"
    """

}
