import 'package:database_query_builder/query_builder.dart';
import 'package:database_query_builder/src/where.dart';
import 'package:test/test.dart';

void main() {
  group('WHERE INSTANCE', () {
    test('Table->where no parameters', () {
      try {
        DB.table('people').where();
      } catch (error) {
        expect(error, equals('required parameters for WHERE'));
      }
    });

    test('Table->where a parameter', () {
      try {
        DB.table('people').where(1);
      } catch (error) {
        expect(
          error,
          equals('required parameters for WHERE, or use DB.raw(your query SQL) '
              'else minimum two parameters are required'),
        );
      }
    });

    test('Table->where parametros invalidos', () {
      try {
        final sql = DB.table('people').where(12, 32);
        expect(sql, isA<WhereExec>());
      } catch (error) {
        expect(
          error,
          equals('requires checking the parameters sent in WHERE'),
        );
      }
    });

    test('Table->where parametros valid', () {
      try {
        final sql = DB.table('people').where('age', 32);
        expect(sql, isA<Where>());
      } catch (error) {
        expect(
          error,
          equals('new error'),
        );
      }
    });
  });

  test('Table->where->toSQL error parameter WhereType.betwee', () {
    try {
      final sql = DB.table('people').where('age', WhereType.equal).toSQL();
      expect(sql, isA<Where>());
    } catch (error) {
      expect(
        error,
        equals('ERROR IN THE QUERY: SELECT * FROM people '
            'WHERE age=@p0 WITH PARAMETES" {p0: WhereType.equal}'),
      );
    }
  });

  test('Table->where', () {
    final sql = DB.table('people').where('age', 32).toSQL();
    expect(sql, equals('SELECT * FROM people WHERE age=32'));
  });

  test('Table->where->toSQL WhereType.equal', () {
    final sql = DB.table('people').where('age', WhereType.equal, 10).toSQL();
    expect(sql, equals('SELECT * FROM people WHERE age=10'));
  });

  test('Table->where->toSQL WhereType.greaterThan', () {
    final sql =
        DB.table('people').where('age', WhereType.greaterThan, 10).toSQL();
    expect(sql, equals('SELECT * FROM people WHERE age>10'));
  });

  test('Table->where->toSQL WhereType.greaterThan', () {
    final sql = DB
        .table('people')
        .where('age', WhereType.greaterThanOrEqual, 10)
        .toSQL();
    expect(sql, equals('SELECT * FROM people WHERE age>=10'));
  });

  test('Table->where->toSQL WhereType.greaterThan', () {
    final sql = DB.table('people').where('age', WhereType.lessThan, 10).toSQL();
    expect(sql, equals('SELECT * FROM people WHERE age<10'));
  });

  test('Table->where->toSQL WhereType.greaterThan', () {
    final sql =
        DB.table('people').where('age', WhereType.lessThanOrEqual, 10).toSQL();
    expect(sql, equals('SELECT * FROM people WHERE age<=10'));
  });

  test('Table->where->toSQL WhereType.greaterThan', () {
    final sql = DB.table('people').where('age', WhereType.like, 10).toSQL();
    expect(sql, equals('SELECT * FROM people WHERE age LIKE 10'));
  });

  test('Table->where->', () {
    final sql = DB
        .table('people')
        .where('age', 32)
        .where('last_name', 'roldan')
        .toSQL();
    expect(
      sql,
      equals("SELECT * FROM people WHERE age=32 AND last_name='roldan'"),
    );
  });
}
