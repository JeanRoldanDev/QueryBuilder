import 'package:database_query_builder/src/filter.dart';
import 'package:database_query_builder/src/sql_query.dart';
import 'package:database_query_builder/src/where.dart';

class Select {
  Where<Filter> select(List<String> parameters) {
    parameters.removeWhere((element) => element.isEmpty);
    SQLquery.instance.selects.addAll(parameters);
    return Where<Filter>();
  }

  Where<Filter> selectDistinct() {
    return Where<Filter>();
  }
}
