import 'package:database_query_builder/src/models.dart';
import 'package:database_query_builder/src/sql_query.dart';
import 'package:database_query_builder/src/table.dart';

typedef Converter<T> = T Function(Map<String, dynamic> row)?;

class DB {
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
