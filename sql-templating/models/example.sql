COPY (FROM read_csv_auto('/dev/stdin')) TO '/dev/stdout' WITH (FORMAT CSV, HEADER)
