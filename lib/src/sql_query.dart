// ignore_for_file: avoid_print

import 'package:postgres/postgres.dart';

typedef JMap = Map<String, dynamic>;
typedef JMapToModel<T> = T Function(JMap);

class SQLquery {
  SQLquery._internal();
  static final _singleton = SQLquery._internal();
  static SQLquery get instance => _singleton;

  String table = '';
  String? primaryKey;
  List<String> query = [];
  Map<String, dynamic> params = {};
  List<String> selects = [];
  String get paramsCode => 'p${params.keys.length}';

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

  Future<String> getPrimaryKey() async {
    return 'select '
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
        "and tco.table_name = '$table'";
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
