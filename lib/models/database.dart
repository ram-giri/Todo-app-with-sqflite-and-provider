import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/models/todo.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  String dbName = "todo.db";
  String tableName = "Todos";
  DatabaseHelper._init();

  Future<Database> get database async {
    _database = await _initDB(dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    String sql = """
    CREATE TABLE "$tableName" (
	"id"	INTEGER,
	"title"	TEXT NOT NULL,
	"discription"	TEXT,
  "isChecked" INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT)
);
    """;
    await db.execute(sql);
  }

  Future<Todo> addTodo(Todo todo) async {
    final db = await instance.database;
    final id = await db.insert(tableName, todo.toMap());
    return todo.copyWith(id: id);
  }

  Future<List<Todo>> listAllTodo() async {
    final db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(
      maps.length,
      (index) => Todo(
        id: maps[index]['id'],
        title: maps[index]['title'],
        discription: maps[index]['discription'],
        isChecked: maps[index]['isChecked'],
      ),
    ).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  // Delete
  Future<bool> deleteTodo(int id) async {
    try {
      final db = await instance.database;
      await db.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<bool> deleteAll() async {
    try {
      final db = await instance.database;
      await db.delete(
        tableName,
      );
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<bool> updateTodo(Todo t) async {
    // Get a reference to the database.
    try {
      final db = await database;
      await db.update(
        tableName,
        t.toMap(),
        where: 'id = ?',
        whereArgs: [t.id],
      );
      return true;
    } catch (ex) {
      return false;
    }
  }
}
