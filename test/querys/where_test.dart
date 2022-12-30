import 'package:database_query_builder/database_query_builder.dart';
import 'package:database_query_builder/src/where.dart';
import 'package:test/test.dart';

void main() {
  test('Table->where empty', () {
    try {
      DB.table('people').where();
    } catch (error) {
      expect(error, 'required parameters for WHERE');
    }
  });

  test('Table->whereIN empty', () {
    final instance = DB.table('people').whereIN('age', [10, 20, 30]);
    expect(instance, isA<Where>());
  });

  test('Table->whereIN empty', () {
    final instance = DB.table('people').whereIN('age', [10, 20, 30]).toSQL();
    expect(instance, equals('SELECT * FROM people WHERE age IN (10, 20, 30)'));
  });
}
