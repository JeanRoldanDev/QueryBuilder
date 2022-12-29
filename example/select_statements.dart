// ignore_for_file: avoid_print

import 'package:database_query_builder/query_builder.dart';

class SelectStatements {
  static Future<void> select() async {
    // Select simple
    final sql1 = DB.table('people').toSQL();
    print(sql1);

    // Select simple with not parameters
    final sql2 = DB.table('people').select([]).toSQL();
    print(sql2);

    // Select simple with  parameters
    final sql3 = DB.table('people').select(['first_name', 'age']).toSQL();
    print(sql3);

    // Select with where
    final sql4 =
        DB.table('people').select(['first_name', 'age']).where('id', 5).toSQL();
    print(sql4);

    // Select nested
    final sql5 = DB
        .table('people')
        .select(['first_name', 'age']).select(['last_name']).toSQL();
    print(sql5);

    // nested select with repeated parameters
    final sql6 = DB
        .table('people')
        .select(['first_name', 'age']).select(['age']).toSQL();
    print(sql6);

    final sql6Data = await DB
        .table('people')
        .select(['first_name', 'age']).select(['age']).get();
    print(sql6Data);
  }
}
