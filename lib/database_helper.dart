import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'mydatabase.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE User(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, username TEXT UNIQUE, email TEXT UNIQUE, password TEXT, avatarIndex INTEGER)',
    );

    // UserActivity tablosunu oluşturuyoruz
    await db.execute(
      'CREATE TABLE UserActivity(id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, activity TEXT, timestamp TEXT, FOREIGN KEY(userId) REFERENCES User(id))',
    );
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    var dbClient = await db;
    return await dbClient!.insert('User', user);
  }

  Future<Map<String, dynamic>?> getUser(
      String username, String password) async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient!.query(
      'User',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    }

    return null;
  }

  // Kullanıcı aktivitesini ekleyen fonksiyon
  Future<int> insertUserActivity(Map<String, dynamic> activity) async {
    var dbClient = await db;
    return await dbClient!.insert('UserActivity', activity);
  }

  // Belirli bir kullanıcının aktivitelerini getiren fonksiyon
  Future<List<Map<String, dynamic>>> getUserActivities(int userId) async {
    var dbClient = await db;
    return await dbClient!.query(
      'UserActivity',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'timestamp DESC', // Aktiviteleri zamana göre sırala
    );
  }
}
