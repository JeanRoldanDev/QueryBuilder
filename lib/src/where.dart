// ignore_for_file: avoid_print, unnecessary_type_check

import 'package:query_builder/src/models.dart';
import 'package:query_builder/src/sql_enums.dart';
import 'package:query_builder/src/sql_query.dart';

class Where {
  Filter where([dynamic arg1, dynamic arg2, dynamic arg3]) {
    final sql = SQLquery.instance;
    final whereExist = sql.query.where((e) => e.contains('WHERE')).length;
    final argWhere = whereExist > 0 ? 'AND' : 'WHERE';

    if (arg1 == null && arg2 == null && arg3 == null) {
      throw 'required parameters for WHERE';
    }

    if (arg1 != null && arg2 == null && arg2 == null) {
      if (arg1 is SqlQuery) {
        sql.query.add('$argWhere ${arg1.value}');
        return Filter();
      } else {
        throw 'required parameters for WHERE, or use DB.raw(your query SQL)';
      }
    }

    if (arg1 != null && arg2 != null && arg3 == null) {
      if (arg1 is String) {
        final p0 = sql.paramsCode;
        sql.params[p0] = arg2;
        sql.query.add('$argWhere $arg1=@$p0');
        return Filter();
      }
    }

    if (arg1 != null && arg2 != null && arg3 != null) {
      if (arg1 is String && arg2 is String) {
        final p0 = sql.paramsCode;
        sql.params[p0] = arg3;
        sql.query.add('$argWhere $arg1$arg2@$p0');
        return Filter();
      }
      if (arg1 is String && arg2 is WhereType) {
        final p0 = sql.paramsCode;
        sql.params[p0] = arg3;
        sql.query.add('$argWhere $arg1${arg2.value}@$p0');
        return Filter();
      }
    }
    throw 'requires checking the parameters sent in WHERE';
  }
}

class Filter extends Data with Where {
  Data orderBy() {
    return Data();
  }

  Data limit() {
    return Data();
  }

  Data groupBy() {
    return Data();
  }
}

class Data extends DataModel {
  Future<List<JMap>> get([
    List<String> parameters = const [],
  ]) async {
    final sql = SQLquery.instance;

    if (sql.query.isEmpty) {
      sql.query.add('SELECT * FROM ${sql.table}');
      return sql.executeQuerySQL<JMap>();
    }
    sql.query.insert(0, 'SELECT * FROM ${sql.table}');
    return sql.executeQuerySQL<JMap>();
  }

  String toSQL() {
    final sql = SQLquery.instance;
    if (sql.query.isEmpty) {
      sql.query.add('SELECT * FROM ${sql.table}');
      return sql.getSQL();
    }
    sql.query.insert(0, 'SELECT * FROM ${sql.table}');
    return sql.getSQL();
  }

  Future<Map<String, dynamic>> first() async {
    return {};
  }
}

class DataModel {
  Future<List<T>> getModel<T>(JMapToModel<T> transform) async {
    final sql = SQLquery.instance;

    if (sql.query.isEmpty) {
      sql.query.add('SELECT * FROM ${sql.table}');
      return sql.executeQuerySQL<T>(transform);
    }

    return sql.executeQuerySQL<T>(transform);
  }
}
