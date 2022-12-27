class DBconnect {
  DBconnect({
    required this.host,
    required this.port,
    required this.databaseName,
    required this.username,
    required this.password,
  });

  final String host;
  final int port;
  final String databaseName;
  final String username;
  final String password;
}

class SqlQuery {
  SqlQuery(this.value);

  final String value;
}
