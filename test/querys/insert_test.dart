import 'package:database_query_builder/query_builder.dart';
import 'package:database_query_builder/src/exec.dart';
import 'package:test/test.dart';

void main() {
  test('Instance Table->insert', () {
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
}
