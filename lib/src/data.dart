import 'package:database_query_builder/src/sql_query.dart';

class SQL {
  String toSQL() {
    final sql = SQLquery.instance;
    return sql.getSQL();
  }
}

mixin DataSQL {
  String toSQL() {
    final sql = SQLquery.instance;
    return sql.getSQL();
  }
}
