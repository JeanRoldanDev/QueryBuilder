import 'package:query_builder/src/sql_query.dart';

class Exec {
  String toSQL() {
    return SQLquery.instance.getSQL();
  }

  Future<int> save() async {
    return SQLquery.instance.executeSQL();
  }
}
