import 'package:database_query_builder/query_builder.dart';

class DeleteStatements {
  static Future<void> updateNotWhere() async {
    final table = DB.table('people').delete()..toSQL();
    await table.where('age', 50).save();
    // await table.save(); // Remove all registers
  }
}
