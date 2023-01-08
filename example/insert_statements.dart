import 'package:database_query_builder/src/db.dart';

class InsertStatements {
  static Future<void> insert() async {
    final execQuery = DB.table('people').insert(
      {
        'first_name': 'new first name',
        'last_name': 'new last name',
        'age': 28,
      },
    );

    execQuery.toSQL();
    await execQuery.save();
  }

  static Future<void> insertAll() async {
    final execQuery = DB.table('people').insertAll([
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
    ]);

    execQuery.toSQL();
    await execQuery.save();
  }

  static Future<List<dynamic>> insertGetId() async {
    final execQuery = DB.table('people').insertGetId(
      {
        'first_name': 'new first name',
        'last_name': 'new last name',
        'age': 28,
      },
      'id',
    );

    execQuery.toSQL();
    return execQuery.save();
  }

  static Future<List<dynamic>> insertAllGetIds() async {
    final execQuery = DB.table('people').insertAllGetIds(
      [
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
      ],
      'id',
    );

    execQuery.toSQL();
    return execQuery.save();
  }
}
