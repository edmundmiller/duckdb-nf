workflow{
    SHEBANG()
}

process SHEBANG {
    debug true
    // input:
    // path blah_csv

    // output:
    // path "output.csv"

    script:
    """
    shebang_duckdb.ddb
    """
}
