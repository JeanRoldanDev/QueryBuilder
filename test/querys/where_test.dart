import 'package:database_query_builder/database_query_builder.dart';
import 'package:database_query_builder/src/where.dart';
import 'package:test/test.dart';

void main() {
  group('WHERE', () {
    test('Table->where empty', () {
      try {
        DB.table('people').where();
      } catch (error) {
        expect(error, 'required parameters for WHERE');
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

    test('Table->where', () async {
      final query = DB.table('people').where('age', 10).toSQL();
      expect(query, isA<String>());
      expect(query, equals('SELECT * FROM people WHERE age=10'));
    });

    test('Table->where->where', () async {
      final query = DB
          .table('people')
          .where('age', 10)
          .where('first_name', 'Jean')
          .toSQL();
      expect(query, isA<String>());
      expect(
        query,
        equals("SELECT * FROM people WHERE age=10 AND first_name='Jean'"),
      );
    });
  });

  group('Table->where WhereType', () {
    test('Table->where', () {
      final query =
          DB.table('people').where('age', WhereType.equal, 10).toSQL();
      expect(query, isA<String>());
      expect(query, equals('SELECT * FROM people WHERE age=10'));
    });

    test('Table->where', () {
      final query =
          DB.table('people').where('age', WhereType.greaterThan, 10).toSQL();
      expect(query, isA<String>());
      expect(query, equals('SELECT * FROM people WHERE age>10'));
    });

    test('Table->where', () {
      final query = DB
          .table('people')
          .where('age', WhereType.greaterThanOrEqual, 10)
          .toSQL();
      expect(query, isA<String>());
      expect(query, equals('SELECT * FROM people WHERE age>=10'));
    });

    test('Table->where', () {
      final query =
          DB.table('people').where('age', WhereType.lessThan, 10).toSQL();
      expect(query, isA<String>());
      expect(query, equals('SELECT * FROM people WHERE age<10'));
    });

    test('Table->where', () {
      final query = DB
          .table('people')
          .where('age', WhereType.lessThanOrEqual, 10)
          .toSQL();
      expect(query, isA<String>());
      expect(query, equals('SELECT * FROM people WHERE age<=10'));
    });

    test('Table->where', () {
      final query = DB.table('people').where('age', WhereType.like, 10).toSQL();
      expect(query, isA<String>());
      expect(query, equals('SELECT * FROM people WHERE age LIKE 10'));
    });
  });

  group('WHERE IN', () {
    test('Table->whereIN empty', () {
      final instance = DB.table('people').whereIN('age', [10, 20, 30]);
      expect(instance, isA<Where>());
    });

    test('Table->whereIN empty', () {
      final instance = DB.table('people').whereIN('age', [10, 20, 30]).toSQL();
      expect(
        instance,
        equals('SELECT * FROM people WHERE age IN (10, 20, 30)'),
      );
    });

    test('Table->whereIN empty', () {
      final instance = DB
          .table('people')
          .whereIN('age', [10, 20]).whereIN('age', [30]).toSQL();
      expect(
        instance,
        equals('SELECT * FROM people WHERE age IN (10, 20) AND age IN (30)'),
      );
    });
  });
}
