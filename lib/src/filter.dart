import 'package:database_query_builder/src/data.dart';

class Filter with Data, DataSQL {
  static String get nameInstanceClass => 'Filter';

  Filter orderBy() {
    return Filter();
  }

  Filter limit() {
    return Filter();
  }

  Filter groupBy() {
    return Filter();
  }
}
