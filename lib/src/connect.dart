// ignore_for_file: avoid_print

import 'package:postgres/postgres.dart';
import 'package:query_builder/src/sql_query.dart';

class Connect {
  factory Connect() {
    return _singleton;
  }

  Connect._internal();
  static final _singleton = Connect._internal();
  static Connect get instance => _singleton;

  PostgreSQLConnection? connection;

  Future<void> init() async {
    final dbconnect = SQLquery.instance.dbconnect!;
    connection = PostgreSQLConnection(
      dbconnect.host,
      dbconnect.port,
      dbconnect.databaseName,
      username: dbconnect.username,
      password: dbconnect.password,
    );

    await connection!.open();

    print('Conection Database Success');
  }
}
