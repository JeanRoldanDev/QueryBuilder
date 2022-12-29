import 'package:database_query_builder/query_builder.dart';

import 'update_statements.dart';

Future<void> main() async {
  DB.conexion(
    databaseName: 'dartpay',
    port: 5442,
  );

  //=========================================================
  //==================> DATA METHODS Statements <=============
  // await DataMethods.get();

  //=========================================================
  //==================> INSERT INTO Statements <=============
  // await InsertStatements.insert();
  // await InsertStatements.insertAll();

  //=========================================================
  //==================> SELECT Statements <==================
  // await SelectStatements.select();

  //=========================================================
  //==================> UPDATE Statements <==================
  await UpdateStatements.updateNotWhere();

  //=========================================================
  //==================> WHERE Statements <==================
}
