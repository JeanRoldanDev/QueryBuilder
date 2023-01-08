import 'package:database_query_builder/src/db.dart';
import 'package:database_query_builder/src/table.dart';
import 'package:database_query_builder/src/where.dart';
import 'package:test/test.dart';

void main() {
  test('Instance Table', () {
    final table = DB.table('people');
    expect(table, isA<Table>());
  });

  test('Table->toSQL', () {
    final sql = DB.table('people').toSQL();
    expect(sql, equals('SELECT * FROM people'));
  });

  group('WHERE', () {
    test('Table->where Instance', () async {
      final sql = DB.table('people').where('age', 10);
      expect(sql, isA<Where>());
    });

    test('Table->where->toSQL', () async {
      final sql = DB.table('people').where('age', 10).toSQL();
      expect(sql, equals('SELECT * FROM people WHERE age=10'));
    });

    test('Table->where->where->toSQL', () async {
      final sql = DB
          .table('people')
          .where('age', 10)
          .where('first_name', 'pepe')
          .toSQL();
      expect(
        sql,
        equals("SELECT * FROM people WHERE age=10 AND first_name='pepe'"),
      );
    });
  });
}
