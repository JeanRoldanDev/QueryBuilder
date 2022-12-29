import 'package:database_query_builder/src/data.dart';
import 'package:database_query_builder/src/sql_query.dart';

class Exec with DataSQL {
  Future<int> save() async {
    return SQLquery.instance.executeSQL();
  }
}
