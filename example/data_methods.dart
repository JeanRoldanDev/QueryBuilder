// ignore_for_file: avoid_print

import 'package:database_query_builder/query_builder.dart';

import 'models/people.dart';

class DataMethods {
  static Future<void> get() async {
    final sql = await DB.table('people').get();
    print(sql);
  }

  static Future<void> toSql() async {
    final sql = DB.table('people').toSQL();
    print(sql);
  }

  static Future<void> getModel() async {
    final sql = await DB.table('people').getModel<People>(People.fromJson);
    print(sql);
  }
}
