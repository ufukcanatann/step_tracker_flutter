import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'steps_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE steps(id INTEGER PRIMARY KEY, step_count INTEGER)',
    );
  }

  Future<void> insertStep(int stepCount) async {
    final db = await database;
    await db.insert(
      'steps',
      {'step_count': stepCount},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> getLatestStepCount() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'steps',
      orderBy: 'id DESC',
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return maps.first['step_count'];
    } else {
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> getAllSteps() async {
    final db = await database;
    return await db.query('steps', orderBy: 'id DESC');
  }
}
