import 'package:database_query_builder/src/sql_query.dart';

class Execute with Exec {}

class Exec {
  Future<int> save() async {
    return SQLquery.instance.executeSQL();
  }
}
