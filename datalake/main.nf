customers = file("https://raw.githubusercontent.com/dbt-labs/jaffle_shop/main/seeds/raw_customers.csv")
orders = file("https://raw.githubusercontent.com/dbt-labs/jaffle_shop/main/seeds/raw_orders.csv")
payments = file("https://raw.githubusercontent.com/dbt-labs/jaffle_shop/main/seeds/raw_payments.csv")

workflow {
    DUCKDB("""
           set s3_access_key_id='test';
           set s3_secret_access_key='test';
           set s3_endpoint='localhost:4566';
           set s3_use_ssl='false';
           set s3_url_style='path';

           -- display tables
           SHOW tables;
           """
    )
    CUSTOMERS_TABLE(
        file("$projectDir/sql/customers_table.sql"),
        customers,
        orders,
        payments
    )
}

// Let DuckDB Read from s3
// This is powerful because DuckDB can pull only the parts it needs in the parquet files
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
    val greaterthan


    script:
    """
    duckdb "SELECT * FROM read_csv('$link', filename=true);
    SELECT region FROM sales GROUP BY region HAVING sum(amount) > $greaterthan;"
    """

    // Could really just be:
    """
    cat $csv
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


// TODO https://duckdb.org/docs/guides/data_viewers/youplot.html
