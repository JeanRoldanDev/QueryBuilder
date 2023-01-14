import 'package:database_query_builder/database_query_builder.dart';
import 'package:database_query_builder/src/data.dart';
import 'package:database_query_builder/src/filter.dart';
import 'package:database_query_builder/src/models.dart';
import 'package:database_query_builder/src/sql_query.dart';

abstract class WhereImpl<T> {
  T where([dynamic arg1, dynamic arg2, dynamic arg3]);
  T whereIN(String column, List<dynamic> values);
  T whereOR();
  T whereNull();

  static T whereINFunc<T>(String column, List<dynamic> params) {
    final sql = SQLquery.instance;
    final whereExist = sql.query.where((e) => e.contains('WHERE')).length;
    final argWhere = whereExist > 0 ? 'AND' : 'WHERE';

    sql.validateEnpty();

    final values = <String>[];
    for (final value in params) {
      final p0 = sql.paramsCode;
      sql.params[p0] = value;
      values.add('@$p0');
    }

    sql.query.add('$argWhere $column IN (${values.join(', ')})');

    return T.toString() == Where.nameInstance ? Where() as T : WhereExec() as T;
  }

  static T whereFunc<T>([dynamic arg1, dynamic arg2, dynamic arg3]) {
    final sql = SQLquery.instance;
    final whereExist = sql.query.where((e) => e.contains('WHERE')).length;
    final argWhere = whereExist > 0 ? 'AND' : 'WHERE';

    if (arg1 == null && arg2 == null && arg3 == null) {
      throw 'required parameters for WHERE';
    }

    sql.validateEnpty();

    //============ Valid for one Arguments
    if (arg1 != null && arg2 == null && arg2 == null) {
      if (arg1 is SqlQuery) {
        sql.query.add('$argWhere ${arg1.value}');
        return T is Where ? Where() as T : WhereExec() as T;
      } else {
        return throw 'required parameters for WHERE, or use '
            'DB.raw(your query SQL) else minimum two parameters are required';
      }
    }

    //============ Valid for two Arguments
    if (arg1 != null && arg2 != null && arg3 == null) {
      if (arg1 is String) {
        final p0 = sql.paramsCode;
        sql.params[p0] = arg2;
        sql.query.add('$argWhere $arg1=@$p0');

        return T.toString() == Where.nameInstance
            ? Where() as T
            : WhereExec() as T;
      }
    }

    //============ Valid for three Arguments
    if (arg1 != null && arg2 != null && arg3 != null) {
      if (arg1 is String && arg2 is String) {
        final p0 = sql.paramsCode;
        sql.params[p0] = arg3;
        sql.query.add('$argWhere $arg1$arg2@$p0');

        return T.toString() == Where.nameInstance
            ? Where() as T
            : WhereExec() as T;
      }
      if (arg1 is String && arg2 is WhereType) {
        final p0 = sql.paramsCode;
        sql.params[p0] = arg3;
        sql.query.add('$argWhere $arg1${arg2.value}@$p0');

        return T.toString() == Where.nameInstance
            ? Where() as T
            : WhereExec() as T;
      }
    }
    return throw 'requires checking the parameters sent in WHERE';
  }
}

class Where extends Filter implements WhereImpl<Where> {
  static String get nameInstance => Where().runtimeType.toString();

  @override
  Where where([dynamic arg1, dynamic arg2, dynamic arg3]) =>
      WhereImpl.whereFunc<Where>(arg1, arg2, arg3);

  @override
  Where whereIN(String column, List<dynamic> values) {
    return WhereImpl.whereINFunc<Where>(column, values);
  }

  @override
  Where whereOR() => throw UnimplementedError('whereOR not available');

  @override
  Where whereNull() => throw UnimplementedError('whereNull not available');
}

class WhereExec extends SQL implements WhereImpl<WhereExec> {
  static String get nameInstance => WhereExec().runtimeType.toString();

  @override
  WhereExec where([dynamic arg1, dynamic arg2, dynamic arg3]) =>
      WhereImpl.whereFunc<WhereExec>(arg1, arg2, arg3);

  @override
  WhereExec whereIN(String column, List<dynamic> values) =>
      WhereImpl.whereINFunc<WhereExec>(column, values);

  @override
  WhereExec whereOR() => throw UnimplementedError('whereOR not available');

  @override
  WhereExec whereNull() => throw UnimplementedError('whereNull not available');
}
