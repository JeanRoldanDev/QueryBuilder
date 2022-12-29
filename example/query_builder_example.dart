import 'package:database_query_builder/query_builder.dart';

Future<void> main() async {
  DB.conexion(
    databaseName: 'dartpay',
    port: 5442,
  );

  //=========================================================
  //==================> DATA METHODS Statements <=============
  // await DataMethods.get();
  // await DataMethods.getModel();
  // await DataMethods.toSql();

  //=========================================================
  //==================> INSERT INTO Statements <=============
  // await InsertStatements.insert();
  // await InsertStatements.insertAll();

  //=========================================================
  //==================> SELECT Statements <==================
  // await SelectStatements.select();

  //=========================================================
  //==================> WHERE Statements <==================
}
