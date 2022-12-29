import 'package:database_query_builder/src/sql_query.dart';

mixin Data {
  Future<List<JMap>> get() async {
    final sql = SQLquery.instance;

    if (sql.query.isEmpty && sql.selects.isEmpty) {
      sql.query.add('SELECT * FROM ${sql.table}');
      return sql.executeQuerySQL<JMap>();
    }

    final select = sql.selects.join(', ');
    sql.query.insert(0, 'SELECT $select FROM ${sql.table}');

    return sql.executeQuerySQL<JMap>();
  }
}

mixin DataSQL {
  String toSQL() {
    final sql = SQLquery.instance;
    if (sql.query.isEmpty) {
      sql.query.add('SELECT * FROM ${sql.table}');
      return sql.getSQL();
    }
    sql.query.insert(0, 'SELECT * FROM ${sql.table}');
    return sql.getSQL();
  }
}

mixin DataModel {
  Future<List<T>> getModel<T>(JMapToModel<T> transform) async {
    final sql = SQLquery.instance;

    if (sql.query.isEmpty && sql.selects.isEmpty) {
      sql.query.add('SELECT * FROM ${sql.table}');
      return sql.executeQuerySQL<T>(transform);
    }

    final select = sql.selects.join(', ');
    sql.query.insert(0, 'SELECT $select FROM ${sql.table}');

    return sql.executeQuerySQL<T>(transform);
  }
}
