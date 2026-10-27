# Wait for SQL Server to be started and then run the sql script
./wait-for-it.sh sql_in_dc:1433 --timeout=0 --strict -- sleep 5s &&

if [ -f /opt/mssql-tools18/bin/sqlcmd ]; then
    /opt/mssql-tools18/bin/sqlcmd -S localhost -i InitializeDatabase.sql -U sa -P "$SA_PASSWORD" -C
else
    /opt/mssql-tools/bin/sqlcmd -S localhost -i InitializeDatabase.sql -U sa -P "$SA_PASSWORD"
fi