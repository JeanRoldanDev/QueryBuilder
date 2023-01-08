// ignore_for_file: cascade_invocations

import 'package:database_query_builder/src/db.dart';

class UpdateStatements {
  static Future<void> updateNotWhere() async {
    final table = DB.table('people').update({'age': 15});
    table.toSQL();
    await table.save();
    await table.where('age', 50).save();
  }
}
