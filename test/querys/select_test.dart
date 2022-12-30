import 'package:database_query_builder/query_builder.dart';
import 'package:database_query_builder/src/select.dart';
import 'package:database_query_builder/src/where.dart';
import 'package:test/test.dart';

void main() {
  test('Instance Table->select', () {
    final execute = DB.table('people').select([]);
    expect(execute, isA<Select>());
  });

  test('Table->select->toSQL empty', () {
    final execute = DB.table('people').select([]).toSQL();

    expect(execute, equals('SELECT * FROM people'));
  });

  test('Table->select->toSQL one parameter', () {
    final execute = DB.table('people').select(['age']).toSQL();

    expect(execute, equals('SELECT age FROM people'));
  });

  test('Table->select->toSQL two parameter', () {
    final execute = DB.table('people').select(['age', 'last_name']).toSQL();

    expect(execute, equals('SELECT age, last_name FROM people'));
  });

  test('Table->select->select->toSQL(', () {
    final execute =
        DB.table('people').select(['age']).select(['last_name']).toSQL();

    expect(execute, equals('SELECT age, last_name FROM people'));
  });

  group('WHERE', () {
    test('Table->select->where Instance', () async {
      final sql = DB.table('people').select([]).where('age', 10);
      expect(sql, isA<Where>());
    });

    test('Table->select->where->toSQL empty', () async {
      final sql = DB.table('people').select([]).where('age', 10).toSQL();
      expect(sql, equals('SELECT * FROM people WHERE age=10'));
    });

    test('Table->select->where->toSQL one parameter', () async {
      final sql = DB.table('people').select(['age']).where('age', 10).toSQL();
      expect(sql, equals('SELECT age FROM people WHERE age=10'));
    });

    test('Table->select->where->toSQL two parameter', () async {
      final sql = DB
          .table('people')
          .select(['age', 'last_name'])
          .where('age', 10)
          .toSQL();
      expect(sql, equals('SELECT age, last_name FROM people WHERE age=10'));
    });

    test('Table->select->select->where->toSQL', () async {
      final sql = DB
          .table('people')
          .select(['age'])
          .select(['last_name'])
          .where('age', 10)
          .toSQL();
      expect(sql, equals('SELECT age, last_name FROM people WHERE age=10'));
    });

    test('Table->select->select->where->where->toSQL', () async {
      final sql = DB
          .table('people')
          .select(['age'])
          .select(['last_name'])
          .where('age', 10)
          .where('first_name', 'pepe')
          .toSQL();
      expect(
        sql,
        equals(
          'SELECT age, last_name '
          "FROM people WHERE age=10 AND first_name='pepe'",
        ),
      );
    });
  });
}
