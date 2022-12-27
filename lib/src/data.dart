import 'package:query_builder/src/sql_query.dart';

class Data extends DataModel {
  Future<List<JMap>> get([
    List<String> parameters = const [],
  ]) async {
    final sql = SQLquery.instance;

    if (sql.query.isEmpty) {
      sql.query.add('SELECT * FROM ${sql.table}');
      return sql.executeQuerySQL<JMap>();
    }
    sql.query.insert(0, 'SELECT * FROM ${sql.table}');
    return sql.executeQuerySQL<JMap>();
  }

  String toSQL() {
    final sql = SQLquery.instance;
    if (sql.query.isEmpty) {
      sql.query.add('SELECT * FROM ${sql.table}');
      return sql.getSQL();
    }
    sql.query.insert(0, 'SELECT * FROM ${sql.table}');
    return sql.getSQL();
  }

  Future<Map<String, dynamic>> first() async {
    return {};
  }
}

class DataModel {
  Future<List<T>> getModel<T>(JMapToModel<T> transform) async {
    final sql = SQLquery.instance;

    if (sql.query.isEmpty) {
      sql.query.add('SELECT * FROM ${sql.table}');
      return sql.executeQuerySQL<T>(transform);
    }

    return sql.executeQuerySQL<T>(transform);
  }
}
