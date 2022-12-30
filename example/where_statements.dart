import 'package:database_query_builder/database_query_builder.dart';

class WhereStatements {
  static Future<void> where() async {
    await DB.table('people').where('age', '10').get();
    await DB.table('people').where('age', WhereType.equal, '10').get();
    await DB.table('people').where('age', WhereType.greaterThan, '10').get();
    await DB
        .table('people')
        .where('age', WhereType.greaterThanOrEqual, '10')
        .get();
    await DB.table('people').where('age', WhereType.lessThan, '10').get();
    await DB
        .table('people')
        .where('age', WhereType.lessThanOrEqual, '10')
        .get();
    await DB.table('people').where('age', WhereType.like, '10').get();

    await DB
        .table('people')
        .where('age', WhereType.greaterThanOrEqual, '10')
        .get();

    await DB.table('people').where('age', WhereType.lessThan, '10').get();

    await DB
        .table('people')
        .where('age', WhereType.lessThanOrEqual, '10')
        .get();

    await DB.table('people').where('first_name', WhereType.like, 'asdas').get();
  }
}
