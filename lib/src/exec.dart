import 'package:database_query_builder/src/sql_query.dart';
import 'package:database_query_builder/src/where.dart';

class Exec extends Where<Exec> {
  String toSQL() {
    return SQLquery.instance.getSQL();
  }

  Future<int> save() async {
    return SQLquery.instance.executeSQL();
  }
}
