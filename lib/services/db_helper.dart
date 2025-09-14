import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  static Database? _database;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'todo_spark.db');

    return await openDatabase(
      path,
      version: 2, // Update the version to reflect schema changes
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        password TEXT,
        profile_photo TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE task (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title_task TEXT,
        description_task TEXT,
        date DATE,
        priority TEXT,
        task TEXT,
        list_point_task TEXT,
        done INTEGER DEFAULT 0,  -- Add done column with default value 0 (false)
        user_id INTEGER,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE note (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title_note TEXT,
        point_note TEXT,
        user_id INTEGER,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE favorit (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        note_id INTEGER,
        task_id INTEGER,
        FOREIGN KEY (note_id) REFERENCES note (id) ON DELETE CASCADE,
        FOREIGN KEY (task_id) REFERENCES task (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE value_favorit (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        favorit_id INTEGER,
        point_favorit TEXT,
        FOREIGN KEY (favorit_id) REFERENCES favorit (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add the 'done' column if it doesn't exist already
      await db.execute('''
        ALTER TABLE task ADD COLUMN done INTEGER DEFAULT 0 
      ''');
    }
  }

  // Insert data
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;

    // Handle special case for 'task' table with 'list_point_task'
    if (table == 'task' && data.containsKey('list_point_task')) {
      data['list_point_task'] = jsonEncode(data['list_point_task']);
    }

    return await db.insert(table, data);
  }

  // Get all data
  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final db = await database;
    final result = await db.query(table);

    if (table == 'task') {
      return result.map((map) {
        final updatedMap = Map<String, dynamic>.from(map);
        if (updatedMap['list_point_task'] != null) {
          updatedMap['list_point_task'] =
              jsonDecode(updatedMap['list_point_task']);
        }
        return updatedMap;
      }).toList();
    }

    return result;
  }

  // Get data by ID
  Future<Map<String, dynamic>?> getById(String table, int id) async {
    final db = await database;
    final res = await db.query(table, where: 'id = ?', whereArgs: [id]);

    if (res.isNotEmpty) {
      final map = Map<String, dynamic>.from(res.first);
      if (table == 'task' && map['list_point_task'] != null) {
        map['list_point_task'] = jsonDecode(map['list_point_task']);
      }
      return map;
    } else {
      return null;
    }
  }

  // Update data
  Future<int> update(String table, Map<String, dynamic> data, int id) async {
    final db = await database;

    // Handle special case for 'task' table with 'list_point_task'
    if (table == 'task' && data.containsKey('list_point_task')) {
      data['list_point_task'] = jsonEncode(data['list_point_task']);
    }

    return await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  // Delete data
  Future<int> delete(String table, int id) async {
    final db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  // Mark task as done (or undone)
  Future<int> markTaskAsDone(int taskId, bool isDone) async {
    final db = await database;

    // Ensure that you're updating the 'done' field properly
    return await db.update(
      'task',
      {'done': isDone ? 1 : 0}, // Use 1 for true and 0 for false
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }
}
