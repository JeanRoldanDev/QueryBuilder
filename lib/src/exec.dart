import 'package:database_query_builder/src/data.dart';
import 'package:database_query_builder/src/sql_query.dart';

class Execute with Exec, DataSQL {}

class Exec {
  Future<int> save() async {
    return SQLquery.instance.executeSQL();
  }
}

class ExecuteAffect with ExecAffect, DataSQL {}

class ExecAffect {
  Future<List<dynamic>> save() async {
    return SQLquery.instance.executeQuerySQLRowAffect();
  }
}
