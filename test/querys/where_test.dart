import 'package:database_query_builder/query_builder.dart';
import 'package:test/test.dart';

void main() {
  test('Table->update empty', () {
    try {
      DB.table('people').where();
    } catch (error) {
      expect(error, 'required parameters for WHERE');
    }
  });
}
