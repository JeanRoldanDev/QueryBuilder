import 'package:database_query_builder/src/models.dart';
import 'package:database_query_builder/src/sql_query.dart';
import 'package:database_query_builder/src/table.dart';

typedef Converter<T> = T Function(Map<String, dynamic> row)?;

class DB {
  static late DBconnect? _dbConnect;
  // static DBconnect get getConexion => _dbConnect!;

  static void conexion({
    String host = 'localhost',
    int port = 5432,
    String databaseName = '',
    String user = 'postgres',
    String password = '',
  }) {
    _dbConnect = DBconnect(
      host: host,
      port: port,
      databaseName: databaseName,
      username: user,
      password: password,
    );
    SQLquery.instance.dbconnect = _dbConnect;
  }

  static Table table(String name) {
    final sqlQuery = SQLquery.instance;
    sqlQuery.query.clear();
    sqlQuery.params.clear();
    sqlQuery.selects.clear();
    sqlQuery.table = name;
    return Table(name);
  }

  static SqlQuery raw(String query) => SqlQuery(query);
}
