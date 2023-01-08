import 'package:database_query_builder/src/data.dart';
import 'package:database_query_builder/src/exec.dart';
import 'package:database_query_builder/src/insert.dart';
import 'package:database_query_builder/src/select.dart';
import 'package:database_query_builder/src/sql_query.dart';
import 'package:database_query_builder/src/where.dart';

class TableExt extends Select with Insert {}

class Table extends TableExt with Data, DataSQL, DataModel {
  Table(this.tableName);

  final String tableName;

  static final query = <String>[];

  Execute drop() => Execute();

  Execute truncate() => Execute();

  WhereExec update(Map<String, dynamic> value) {
    final sql = SQLquery.instance;
    sql.query.add('UPDATE ${sql.table} SET');

    final values = <String>[];
    value.forEach((key, value) {
      final p0 = sql.paramsCode;
      sql.params[p0] = value;
      values.add('$key=@$p0');
    });

    if (value.isEmpty) {
      return throw 'required parameters for UPDATE';
    }
    sql.query.add(values.join(', '));
    return WhereExec();
  }

  WhereExec delete() {
    final sql = SQLquery.instance;
    sql.query.add('DELETE FROM ${sql.table}');
    return WhereExec();
  }
}
