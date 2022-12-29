import 'package:database_query_builder/src/data.dart';
import 'package:database_query_builder/src/sql_query.dart';

class Execute with Exec, DataSQL {}

class Exec {
  Future<int> save() async {
    return SQLquery.instance.executeSQL();
  }
}
