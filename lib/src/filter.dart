import 'package:database_query_builder/src/data.dart';

class Filter with Data, DataSQL, DataModel {
  Filter orderBy() => Filter();
  Filter groupBy() => Filter();
  Filter limit() => Filter();
}
