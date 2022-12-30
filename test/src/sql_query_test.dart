import 'package:database_query_builder/src/sql_query.dart';
import 'package:test/test.dart';

void main() {
  test('SQLquery instance singlenton', () {
    final instance = SQLquery.instance;
    expect(instance, isA<SQLquery>());
  });

  test('SQLquery instance factory', () {
    final instance = SQLquery();
    expect(instance, isA<SQLquery>());
  });
}
