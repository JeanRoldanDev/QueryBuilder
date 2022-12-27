import 'package:query_builder/src/exec.dart';
import 'package:query_builder/src/sql_query.dart';
import 'package:query_builder/src/where.dart';

class Table extends Data with Where {
  Table(this.tableName);

  final String tableName;

  static final query = <String>[];

  Exec insert(Map<String, dynamic> value) {
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

    return Exec();
  }

  Exec insertAll(List<JMap> values) {
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
    return Exec();
  }

  Where select() {
    return Where();
  }

  Where selectDistinct() {
    return Where();
  }
}
