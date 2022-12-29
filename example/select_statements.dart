// ignore_for_file: avoid_print

import 'package:database_query_builder/query_builder.dart';

class SelectStatements {
  static Future<void> select() async {
    await DB.table('people').get();
    await DB.table('people').select([]).get();
    await DB.table('people').select(['first_name', 'age']).get();
    await DB.table('people').select(['first_name', 'age']).where('id', 5).get();
  }
}
