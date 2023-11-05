import 'package:employee_tracker/models/employee.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final sharedInstance = DatabaseHelper._();
  DatabaseHelper._();

  static const _databaseName = "employee_database.db";
  static const _databaseVersion = 1;

  static const table = 'employee';

  late Database _db;

  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table (id INTEGER PRIMARY KEY, name TEXT, role TEXT, fromDate TEXT, toDate TEXT)');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insertEmployee(Employee employee) async {
    return await _db.insert(table, employee.toMap());
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Employee>> getEmployeeList() async {
    final List<Map<String, dynamic>> maps = await _db.query(table);
    return List.generate(maps.length, (i) {
      return Employee.fromMap(maps[i]);
    });
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<void> updateEmployee(Employee employee) async {
    await _db.update(
      table,
      employee.toMap(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<void> deleteEmployee(int id) async {
    await _db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
