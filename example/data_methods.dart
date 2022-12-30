// ignore_for_file: avoid_print, cascade_invocations

import 'package:database_query_builder/query_builder.dart';

import 'models/people.dart';

class DataMethods {
  static Future<void> get() async {
    final queryBuild = DB.table('people');

    queryBuild.toSQL();
    await queryBuild.get();
    await queryBuild.getModel<People>(People.fromJson);
  }
}
