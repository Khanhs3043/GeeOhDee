import 'package:chos/models/myUser.dart';
import 'package:sqflite/sqflite.dart';

import '../models/myUser.dart';

class DbHelper {
  static Future<Database> mDatabase() async {
    return await openDatabase(
        'dog.db',
        version: 1,
        onCreate: (Database database, int version) async {
          await createTable(database);
        }
    );
  }

  static Future<void> createTable(Database database) async {
    await database.execute('''
          CREATE TABLE IF NOT EXISTS FAVORITES (
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        DogId INTEGER,
        UserId INTEGER,
        FOREIGN KEY (UserId) REFERENCES users(id)
      )
    ''');
    await database.execute('''
          CREATE TABLE IF NOT EXISTS USERS (
        Id TEXT PRIMARY KEY,
        Email TEXT ,
        Password TEXT,
        Name TEXT ,
        Dob TEXT ,
        Gender TEXT 
      )
    ''');
  }

// Thêm một người dùng mới vào bảng
  static Future<void> createUser(MyUser user) async {
    Database db = await mDatabase();
    await db.insert('users', user.toMap());
  }

  // Lấy thông tin người dùng dựa trên ID
  static Future<MyUser?> getUserById(String id) async {
    Database db = await mDatabase();
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'Id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return null;
    }
    return MyUser.fromMap(maps.first);
  }

  // Cập nhật thông tin người dùng
  static Future<void> updateUser(MyUser user) async {
    Database db = await mDatabase();
    await db.update(
      'users',
      user.toMap(),
      where: 'Id = ?',
      whereArgs: [user.id],
    );
  }

  // Xóa người dùng khỏi bảng dựa trên ID
  static Future<void> deleteUser(String id) async {
    Database db = await mDatabase();
    await db.delete(
      'users',
      where: 'Id = ?',
      whereArgs: [id],
    );
  }

}