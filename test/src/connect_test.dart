import 'package:database_query_builder/src/connect.dart';
import 'package:database_query_builder/src/models.dart';
import 'package:database_query_builder/src/sql_query.dart';
import 'package:test/test.dart';

void main() {
  test('Connect Instance', () {
    final instance = Connect.instance;
    final instance2 = Connect();
    expect(instance, isA<Connect>());
    expect(instance2, isA<Connect>());
  });

  test('Connect init', () async {
    SQLquery.instance.dbconnect = DBconnect(
      host: 'localhost',
      databaseName: 'dartbase',
      port: 5442,
      username: 'postgres',
      password: '',
    );

    var status = true;
    try {
      await Connect.instance.init();
    } catch (e) {
      status = false;
    }
    expect(status, isTrue);
  });
}
