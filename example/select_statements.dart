// ignore_for_file: avoid_print

import 'package:database_query_builder/query_builder.dart';

import 'models/people.dart';

class SelectStatements {
  static Future<void> select() async {
    final table = DB.table('people');
    // Select direct
    await table.get();

    // Select simple
    table.toSQL();

    // Select direct to Model
    await table.getModel<People>(People.fromJson);

    // Select simple with not parameters
    table.select([]).toSQL();

    // Select simple with  parameters
    table.select(['first_name', 'age']).toSQL();

    // Select with where
    table.select(['first_name', 'age']).where('id', 5).toSQL();

    // Select nested
    table.select(['first_name', 'age']).select(['last_name']).toSQL();

    // nested select with repeated parameters
    table.select(['first_name', 'age']).select(['age']).toSQL();

    final keys =
        await table.select(['first_name', 'age']).select(['age']).get();
    print(keys.first.keys);
  }
}
