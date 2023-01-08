// ignore_for_file: avoid_print

import 'package:database_query_builder/src/connect.dart';
import 'package:database_query_builder/src/models.dart';
import 'package:postgres/postgres.dart';

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
  String? primaryKey;
  List<String> query = [];
  Map<String, dynamic> params = {};
  List<String> selects = [];
  String get paramsCode => 'p${params.keys.length}';
  DBconnect? dbconnect;

  String getSQL() {
    try {
      validateEnpty();

      final sql = query.join(' ');
      final queryResult = PostgreSQLFormat.substitute(sql, params);
      selects.clear();
      print('SQL: $queryResult');
      return queryResult;
    } catch (e) {
      final sql = query.join(' ');
      return throw 'ERROR IN THE QUERY: $sql WITH PARAMETES" $params';
    }
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
    print('SQL: ${PostgreSQLFormat.substitute(sql, params)}');

    final response = await connect.connection!.query(
      sql,
      substitutionValues: params,
    );

    final result = <T>[];

    for (final row in response) {
      final map = <String, dynamic>{};
      for (var i = 0; i < row.columnDescriptions.length; i++) {
        final column = row.columnDescriptions;
        var key = column[i].columnName;
        if (map.containsKey(key)) {
          key = '$key' '_column$i';
        }
        map[key] = row[i];
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
    print('SQL: ${PostgreSQLFormat.substitute(sql, params)}');

    final result = await connect.connection!.execute(
      sql,
      substitutionValues: params,
    );
    print('AFFECTED ROWS:: $result');

    return result;
  }

  Future<List<dynamic>> executeQuerySQLRowAffect() async {
    final connect = Connect.instance;

    if (dbconnect == null) {
      throw 'requires initializing a database connection, '
          'use DB.conexion';
    }

    if (connect.connection == null) {
      await connect.init();
    }

    if (primaryKey == null) {
      primaryKey = await getPrimaryKey();
      query.add(primaryKey!);
    }

    final queryExec = await executeQuerySQL<JMap>();
    return queryExec.map((e) => e[primaryKey]).toList();
  }

  Future<String> getPrimaryKey() async {
    print('=========== CONSULTA ALKDHADLKASHSDLAK');
    final connect = Connect.instance;

    if (dbconnect == null) {
      throw 'requires initializing a database connection, '
          'use DB.conexion';
    }

    if (connect.connection == null) {
      await connect.init();
    }

    final result = await connect.connection!.query(
      'select '
      'kcu.table_schema, '
      'kcu.table_name, '
      'tco.constraint_name, '
      'kcu.ordinal_position as position, '
      'kcu.column_name as key_column '
      'from information_schema.table_constraints tco '
      'join information_schema.key_column_usage kcu '
      'on kcu.constraint_name = tco.constraint_name '
      'and kcu.constraint_schema = tco.constraint_schema '
      'and kcu.constraint_name = tco.constraint_name '
      "where tco.constraint_type = 'PRIMARY KEY' "
      "and tco.table_name = '$table'",
    );

    return result.first[4].toString();
  }

  void validateEnpty() {
    if (query.isEmpty && selects.isEmpty) {
      query.add('SELECT * FROM $table');
    }

    if (query.isEmpty && selects.isNotEmpty) {
      final parameter = selects.join(', ');
      query.add('SELECT $parameter FROM $table');
    }
  }
}
