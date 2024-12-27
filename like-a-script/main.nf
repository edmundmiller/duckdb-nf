process LIKEASCRIPT {
    input:
    path blah_csv

    output:
path "output.csv"
    script:
    """
    cat path/to/source.csv | duckdb :memory: -c ".read test.sql" > output.csv
    """
}
