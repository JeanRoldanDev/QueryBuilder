// ignore_for_file: avoid_print

import 'package:postgres/postgres.dart';
import 'package:query_builder/src/connect.dart';
import 'package:query_builder/src/models.dart';

typedef JMap = Map<String, dynamic>;
typedef JMapToModel<T> = T Function(JMap);

class SQLquery {
  factory SQLquery() {
    return _singleton;
  }

  SQLquery._internal();
  static final _singleton = SQLquery._internal();
  static SQLquery get instance => _singleton;

  String table = '';
  List<String> query = [];
  Map<String, dynamic> params = {};
  String get paramsCode => 'p${params.keys.length}';
  DBconnect? dbconnect;

  String getSQL() {
    final sql = query.join(' ');
    return PostgreSQLFormat.substitute(sql, params);
  }

  String cleanRaw(String fmtString) {
    return PostgreSQLFormat.substitute(fmtString, null);
  }

  Future<List<T>> executeQuerySQL<T>([JMapToModel<T>? transform]) async {
    final connect = Connect.instance;

    if (dbconnect == null) {
      throw 'requires initializing a database connection, '
          'use DB.conexion';
    }

    if (connect.connection == null) {
      await connect.init();
    }

    final sql = query.join(' ');
    print('==============================================================>');
    print('1) QUERY: $sql');
    print('2) PARAMETER: $params');
    print('3) SQL EXECUTE QUERY: ${PostgreSQLFormat.substitute(sql, params)}');

    final response = await connect.connection!.query(
      sql,
      substitutionValues: params,
    );

    final result = <T>[];

    for (final row in response) {
      final map = <String, dynamic>{};
      for (var i = 0; i < row.columnDescriptions.length; i++) {
        final column = row.columnDescriptions;
        map[column[i].columnName] = row[i];
      }

      if (transform != null) {
        result.add(transform.call(map));
      } else {
        result.add(map as T);
      }
    }

    return result;
  }

  Future<int> executeSQL() async {
    final connect = Connect.instance;

    if (dbconnect == null) {
      throw 'requires initializing a database connection, '
          'use DB.conexion';
    }

    if (connect.connection == null) {
      await connect.init();
    }

    final sql = query.join(' ');
    print('==============================================================>');
    print('1) QUERY: $sql');
    print('2) PARAMETER: $params');
    print('3) SQL EXECUTE QUERY: ${PostgreSQLFormat.substitute(sql, params)}');

    final result = await connect.connection!.execute(
      sql,
      substitutionValues: params,
    );

    return result;
  }
}
