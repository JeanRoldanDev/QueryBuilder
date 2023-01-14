void main() {
  // group('SELECT', () {
  //   test('Direct', () async {
  //     final query = DB.table('people').select(['age']);

  //     final t1 = await query.get();
  //     final t2 = query.toSQL();

  //     expect(query, isA<Select>());
  //     expect(t1, isA<List<Map<String, dynamic>>>());
  //     expect(t2, equals('SELECT age FROM people'));
  //   });

  //   test('Where', () async {
  //     final query = DB.table('people').select(['age']).where('age', 10);

  //     final t1 = await query.get();
  //     final t2 = query.toSQL();

  //     expect(query, isA<Where>());
  //     expect(t1, isA<List<Map<String, dynamic>>>());
  //     expect(
  //       t2,
  //       equals('SELECT age FROM people WHERE age=10'),
  //     );
  //   });

  //   test('Where doble', () async {
  //     final query = DB
  //         .table('people')
  //         .select(['age'])
  //         .where('age', WhereType.equal, 10)
  //         .whereIN('age', [10, 20])
  //         .where('first_name', '=', 'Jean');

  //     final t1 = await query.get();
  //     final t2 = query.toSQL();

  //     expect(query, isA<Where>());
  //     expect(t1, isA<List<Map<String, dynamic>>>());
  //     expect(
  //       t2,
  //       equals(
  //         'SELECT age FROM people WHERE age=10 AND age IN (10, 20) AND '
  //         "first_name='Jean'",
  //       ),
  //     );
  //   });
  // });

  // group('UPDATE', () {
  //   test('Direct', () async {
  //     final query = DB.table('people').update({'age': 15});

  //     final t1 = await query.save();
  //     final t2 = query.toSQL();

  //     expect(query, isA<WhereExec>());
  //     expect(t1, isA<int>());
  //     expect(t2, equals('UPDATE people SET age=15'));
  //   });

  //   test('Where', () async {
  //     final query = DB
  //         .table('people')
  //         .update({'age': 15})
  //         .where('age', '10')
  //         .where('first_name', '=', 'Jean');

  //     final t1 = await query.save();
  //     final t2 = query.toSQL();

  //     expect(query, isA<WhereExec>());
  //     expect(t1, isA<int>());
  //     expect(
  //       t2,
  //       equals(
  //         "UPDATE people SET age=15 WHERE age='10' AND first_name='Jean'",
  //       ),
  //     );
  //   });

  //   test('Where IN', () async {
  //     final query =
  //         DB.table('people').update({'age': 15}).whereIN('age', [10, 20]);

  //     final t1 = await query.save();
  //     final t2 = query.toSQL();

  //     expect(query, isA<WhereExec>());
  //     expect(t1, isA<int>());
  //     expect(t2, equals('UPDATE people SET age=15 WHERE age IN (10, 20)'));
  //   });

  //   test('Where doble', () async {
  //     final query = DB
  //         .table('people')
  //         .update({'age': 15})
  //         .where('age', WhereType.equal, 10)
  //         .whereIN('age', [10, 20]);

  //     final t1 = await query.save();
  //     final t2 = query.toSQL();

  //     expect(query, isA<WhereExec>());
  //     expect(t1, isA<int>());
  //     expect(
  //       t2,
  //       equals('UPDATE people SET age=15 WHERE age=10 AND age IN (10, 20)'),
  //     );
  //   });
  // });

  // group('WHERE IN', () {
  //   test('Direct', () async {
  //     final query = DB.table('people').whereIN('age', [10, 20]);

  //     final t1 = await query.get();
  //     final t2 = query.toSQL();

  //     expect(query, isA<Where>());
  //     expect(t1, isA<List<Map<String, dynamic>>>());
  //     expect(t2, equals('SELECT * FROM people WHERE age IN (10, 20)'));
  //   });

  //   test('Select', () async {
  //     final query = DB.table('people').select(['age', 'first_name']).whereIN(
  //       'age',
  //       [10, 20],
  //     );

  //     final t1 = await query.get();
  //     final t2 = query.toSQL();

  //     expect(query, isA<Where>());
  //     expect(t1, isA<List<Map<String, dynamic>>>());
  //     expect(
  //       t2,
  //       equals(
  //         'SELECT age, first_name FROM people WHERE age IN (10, 20)',
  //       ),
  //     );
  //   });

  //   test('Update', () async {
  //     final query =
  //         DB.table('people').update({'age': 15}).whereIN('age', [10, 20]);

  //     final t1 = await query.save();
  //     final t2 = query.toSQL();

  //     expect(query, isA<WhereExec>());
  //     expect(t1, isA<int>());
  //     expect(t2, equals('UPDATE people SET age=15 WHERE age IN (10, 20)'));
  //   });
  // });
}
