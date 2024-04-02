import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'notes.db';

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Define table structure and create the table
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      '$dbPath/$_databaseName',
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE Notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            timestamp INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  // Implement methods for CRUD operations on notes (using sqflite)
}
