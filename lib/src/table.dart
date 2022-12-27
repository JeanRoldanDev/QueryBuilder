import 'package:query_builder/src/where.dart';

class Table extends Data with Where {
  Table(
    this.tableName,
  );

  final String tableName;

  static final query = <String>[];

  void insert(List<Map<String, dynamic>> value) {
    UnimplementedError('function INSERT not implement');
  }

  Where select() {
    return Where();
  }

  Where selectDistinct() {
    return Where();
  }
}
