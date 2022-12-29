import 'package:database_query_builder/src/data.dart';
import 'package:database_query_builder/src/exec.dart';
import 'package:database_query_builder/src/sql_query.dart';
import 'package:database_query_builder/src/where.dart';

class Table extends Data {
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

  Where<Exec> update(Map<String, dynamic> value) {
    final sql = SQLquery.instance;
    sql.query.add('UPDATE ${sql.table} SET');

    final values = <String>[];
    value.forEach((key, value) {
      final p0 = sql.paramsCode;
      sql.params[p0] = value;
      values.add('$key=@$p0');
    });
    sql.query.add(values.join(', '));

    return Where<Exec>();
  }

  Where<Filter> select(List<String> parameters) {
    SQLquery.instance.selects.addAll(parameters);
    return Where<Filter>();
  }

  Where<Filter> selectDistinct() {
    return Where<Filter>();
  }

  Filter where([dynamic arg1, dynamic arg2, dynamic arg3]) {
    return Where.whereInternal(arg1, arg2, arg3);
  }
}
