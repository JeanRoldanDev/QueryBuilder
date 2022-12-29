// ignore_for_file: avoid_print

import 'package:database_query_builder/query_builder.dart';

class InsertStatements {
  static Future<void> insert() async {
    final sql = await DB.table('people').insert(
      {
        'first_name': 'new first name',
        'last_name': 'new last name',
        'age': 28,
      },
    ).save();
    print('INSERT: $sql');
  }

  static Future<void> insertAll() async {
    final sql = await DB.table('people').insertAll([
      {
        'first_name': 'new first name 1',
        'last_name': 'new first last name 1',
        'age': 12,
      },
      {
        'first_name': 'new first name 2',
        'last_name': 'new first last name 2',
        'age': 17,
      },
      {
        'first_name': 'new first last name 3',
        'last_name': 'new first last name 3',
        'age': 118,
      }
    ]).save();
    print('INSERT ALL: $sql');
  }
}
