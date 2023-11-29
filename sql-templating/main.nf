nextflix_top_10 = file("https://github.com/mehd-io/duckdb-playground-tutorial/raw/main/data/netflix_daily_top_10.csv")

process DUCKDB_SQL_FILE {
    input:
    file query_file
    file csv

    script:
    """
    cat $csv | duckdb -c ".read $query_file"
    # This file is in bin/!
    cat $csv | duckdb :memory: -c ".read bin_example.sql"
    """
}


workflow {
    DUCKDB_SQL_FILE(
        file("$projectDir/models/example.sql"),
        nextflix_top_10
    )
}
