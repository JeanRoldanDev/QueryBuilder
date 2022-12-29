import 'package:database_query_builder/src/data.dart';
import 'package:database_query_builder/src/exec.dart';
import 'package:database_query_builder/src/select.dart';
import 'package:database_query_builder/src/sql_query.dart';
import 'package:database_query_builder/src/where.dart';

class Table extends Select with Data, DataSQL, DataModel {
  Table(this.tableName);

  final String tableName;

  static final query = <String>[];

  Execute drop() => Execute();

  Execute truncate() => Execute();

  Execute insert(Map<String, dynamic> value) {
    final sql = SQLquery.instance;
    sql.query.add('INSERT INTO ${sql.table}');
    sql.query.add('(${value.keys.join(', ')})');

    final values = <String>[];
    value.forEach((key, value) {
      final p0 = sql.paramsCode;
      sql.params[p0] = value;
      values.add('@$p0');
    });

    sql.query.add('VALUES (${values.join(', ')})');

    return Execute();
  }

  Execute insertAll(List<JMap> values) {
    final sql = SQLquery.instance;
    sql.query.add('INSERT INTO ${sql.table}');
    sql.query.add('(${values.first.keys.join(', ')})');
    sql.query.add('VALUES');

    final listValues = <dynamic>[];
    for (final item in values) {
      final values = <String>[];
      item.forEach((key, value) {
        final p0 = sql.paramsCode;
        sql.params[p0] = value;
        values.add('@$p0');
      });
      listValues.add('(${values.join(', ')})');
    }
    sql.query.add('${listValues.join(', ')};');
    return Execute();
  }

  WhereExec update(Map<String, dynamic> value) {
    final sql = SQLquery.instance;
    sql.query.add('UPDATE ${sql.table} SET');

    final values = <String>[];
    value.forEach((key, value) {
      final p0 = sql.paramsCode;
      sql.params[p0] = value;
      values.add('$key=@$p0');
    });
    sql.query.add(values.join(', '));

    return WhereExec();
  }
}
