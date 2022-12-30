import 'package:database_query_builder/src/join.dart';
import 'package:database_query_builder/src/sql_query.dart';

class Select extends Join {
  Select select(List<String> parameters) {
    parameters.removeWhere((element) => element.isEmpty);
    SQLquery.instance.selects.addAll(parameters);
    return Select();
  }

  Select selectDistinct() {
    return Select();
  }
}
