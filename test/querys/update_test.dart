import 'package:database_query_builder/src/db.dart';
import 'package:database_query_builder/src/where.dart';
import 'package:test/test.dart';

void main() {
  group('WHERE INSTANCE', () {
    test('Table->where no parameters', () {
      final instance = DB.table('people').update({
        'firstName': 'new first name',
        'lastName': 'new last name',
      });
      expect(instance, isA<WhereExec>());
    });

    test('Table->where no parameters', () {
      final instance = DB.table('people').update({
        'firstName': 'new first name',
        'lastName': 'new last name',
      }).toSQL();
      expect(instance, isA<String>());
      expect(
        instance,
        equals(
          'UPDATE people SET '
          "firstName='new first name', lastName='new last name'",
        ),
      );
    });

    test('Table->where no parameters', () {
      final instance = DB
          .table('people')
          .update({
            'firstName': 'new first name',
            'lastName': 'new last name',
          })
          .where('age', 10)
          .toSQL();
      expect(
        instance,
        equals(
          'UPDATE people SET '
          "firstName='new first name', lastName='new last name' WHERE age=10",
        ),
      );
    });
  });
}
