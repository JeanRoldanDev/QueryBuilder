import 'package:database_query_builder/src/db.dart';
import 'package:database_query_builder/src/exec.dart';
import 'package:test/test.dart';

void main() {
  group('INSERT', () {
    test('Table->insert Instance', () {
      final execute = DB.table('people').insert(
        {
          'first_name': 'new first name',
          'last_name': 'new last name',
          'age': 28,
        },
      );
      expect(execute, isA<Execute>());
    });

    test('Table->insert->toSQL', () {
      final execute = DB.table('people').insert(
        {
          'first_name': 'new first name',
          'last_name': 'new last name',
          'age': 28,
        },
      ).toSQL();

      expect(
        execute,
        equals(
          'INSERT INTO people (first_name, last_name, age) VALUES '
          "('new first name', 'new last name', 28)",
        ),
      );
    });

    test('Table->insertAll->toSQL', () {
      final execute = DB.table('people').insertAll([
        {
          'first_name': 'new first name 0',
          'last_name': 'new last name 0',
          'age': 28,
        },
        {
          'first_name': 'new first name 1',
          'last_name': 'new last name 1',
          'age': 6,
        },
      ]).toSQL();

      expect(
        execute,
        equals(
          'INSERT INTO people (first_name, last_name, age) VALUES '
          "('new first name 0', 'new last name 0', 28), "
          "('new first name 1', 'new last name 1', 6);",
        ),
      );
    });
  });

  group('INSERT GET ID', () {
    test('Table->insertGetId Instance', () {
      final execute = DB.table('people').insertGetId(
        {
          'first_name': 'new first name',
          'last_name': 'new last name',
          'age': 28,
        },
      );
      expect(execute, isA<ExecuteAffect>());
    });

    test('Table->insertGetId->toSQL NO Primary Key', () {
      final execute = DB.table('people').insertGetId(
        {
          'first_name': 'new first name',
          'last_name': 'new last name',
          'age': 28,
        },
      ).toSQL();

      expect(
        execute,
        equals(
          'INSERT INTO people (first_name, last_name, age) VALUES '
          "('new first name', 'new last name', 28) RETURNING",
        ),
      );
    });

    test('Table->insertGetId->toSQL', () {
      final execute = DB.table('people').insertGetId(
        {
          'first_name': 'new first name',
          'last_name': 'new last name',
          'age': 28,
        },
        'id',
      ).toSQL();

      expect(
        execute,
        equals(
          'INSERT INTO people (first_name, last_name, age) VALUES '
          "('new first name', 'new last name', 28) RETURNING id",
        ),
      );
    });

    test('Table->insertAllGetIds Instance', () {
      final execute = DB.table('people').insertAllGetIds(
        [
          {
            'first_name': 'new first name 0',
            'last_name': 'new last name 0',
            'age': 28,
          },
          {
            'first_name': 'new first name 1',
            'last_name': 'new last name 1',
            'age': 6,
          },
        ],
      );

      expect(execute, isA<ExecuteAffect>());
    });

    test('Table->insertAllGetIds>toSQL NO Primary Key', () {
      final execute = DB.table('people').insertAllGetIds(
        [
          {
            'first_name': 'new first name 0',
            'last_name': 'new last name 0',
            'age': 28,
          },
          {
            'first_name': 'new first name 1',
            'last_name': 'new last name 1',
            'age': 6,
          },
        ],
      ).toSQL();

      expect(
        execute,
        equals(
          'INSERT INTO people (first_name, last_name, age) VALUES '
          "('new first name 0', 'new last name 0', 28), "
          "('new first name 1', 'new last name 1', 6) RETURNING",
        ),
      );
    });

    test('Table->insertAllGetIds>toSQL', () {
      final execute = DB.table('people').insertAllGetIds(
        [
          {
            'first_name': 'new first name 0',
            'last_name': 'new last name 0',
            'age': 28,
          },
          {
            'first_name': 'new first name 1',
            'last_name': 'new last name 1',
            'age': 6,
          },
        ],
        'id',
      ).toSQL();

      expect(
        execute,
        equals(
          'INSERT INTO people (first_name, last_name, age) VALUES '
          "('new first name 0', 'new last name 0', 28), "
          "('new first name 1', 'new last name 1', 6) RETURNING id",
        ),
      );
    });
  });
}
