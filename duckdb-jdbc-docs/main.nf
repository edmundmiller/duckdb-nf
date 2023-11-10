include { fromQuery } from 'plugin/nf-sqldb'

// ORIGINAL
// create a table
// Statement stmt = conn.createStatement();
// stmt.execute("CREATE TABLE items (item VARCHAR, value DECIMAL(10, 2), count INTEGER)");
// insert two items into the table
// stmt.execute("INSERT INTO items VALUES ('jeans', 20.0, 1), ('hammer', 42.2, 2)");

include { sqlInsert } from 'plugin/nf-sqldb'

channel
    .of(tuple('jeans', 20.0, 1), tuple('hammer', 42.2, 2))
    .sqlInsert( into: 'items',
               // columns: 'item, value, count',
               db: 'my-db',
               setup: "CREATE TABLE IF NOT EXISTS items (item VARCHAR, value DECIMAL(10, 2), count INTEGER)" )