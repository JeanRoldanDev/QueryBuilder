import 'package:database_query_builder/src/exec.dart';
import 'package:database_query_builder/src/filter.dart';
import 'package:database_query_builder/src/models.dart';
import 'package:database_query_builder/src/sql_enums.dart';
import 'package:database_query_builder/src/sql_query.dart';

class Where extends Filter {
  Where where([dynamic arg1, dynamic arg2, dynamic arg3]) {
    final sql = SQLquery.instance;
    final whereExist = sql.query.where((e) => e.contains('WHERE')).length;
    final argWhere = whereExist > 0 ? 'AND' : 'WHERE';

    if (arg1 == null && arg2 == null && arg3 == null) {
      throw 'required parameters for WHERE';
    }

    if (arg1 != null && arg2 == null && arg2 == null) {
      if (arg1 is SqlQuery) {
        sql.query.add('$argWhere ${arg1.value}');
        return Where();
      } else {
        throw 'required parameters for WHERE, or use DB.raw(your query SQL)';
      }
    }

    if (arg1 != null && arg2 != null && arg3 == null) {
      if (arg1 is String) {
        final p0 = sql.paramsCode;
        sql.params[p0] = arg2;
        sql.query.add('$argWhere $arg1=@$p0');

        return Where();
      }
    }

    if (arg1 != null && arg2 != null && arg3 != null) {
      if (arg1 is String && arg2 is String) {
        final p0 = sql.paramsCode;
        sql.params[p0] = arg3;
        sql.query.add('$argWhere $arg1$arg2@$p0');

        return Where();
      }
      if (arg1 is String && arg2 is WhereType) {
        final p0 = sql.paramsCode;
        sql.params[p0] = arg3;
        sql.query.add('$argWhere $arg1${arg2.value}@$p0');

        return Where();
      }
    }
    throw 'requires checking the parameters sent in WHERE';
  }
}

class WhereExec extends Execute {
  WhereExec where() => WhereExec();
}
