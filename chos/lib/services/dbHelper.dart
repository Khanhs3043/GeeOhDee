import 'package:chos/models/favoriteDog.dart';
import 'package:chos/models/myUser.dart';
import 'package:chos/services/dogService.dart';
import 'package:sqflite/sqflite.dart';

import '../models/dog.dart';
import '../models/myUser.dart';

class DbHelper {
  static Future<Database> mDatabase() async {
    return await openDatabase(
        'dog.db',
        version: 1,
        onCreate: (Database database, int version) async {
          //await updateTableStructure(database);

          await createTable(database);
          print('jjjj drop');
        }
    );
  }
  static Future<void> updateTableStructure(Database db) async {
    await db.execute('DROP TABLE if exists favorites');
    //await db.execute('CREATE TABLE favorites (id INTEGER PRIMARY KEY, dogId INTEGER, userId TEXT)');
  }
  static Future<void> createTable(Database database) async {
    await database.execute('''
    
          CREATE TABLE IF NOT EXISTS FAVORITES (
         id INTEGER PRIMARY KEY AUTOINCREMENT,
      dogId INTEGER ,
      userId TEXT ,
      weight TEXT,
      height TEXT,
      name TEXT,
      bred_for TEXT,
      breed_group TEXT,
      life_span TEXT,
      temperament TEXT,
      origin TEXT,
      reference_image_id TEXT,
      FOREIGN KEY (userId) REFERENCES users(id)
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
  // about favorite------------------------------------------------------------------
  static Future<int> addFavorite(FavoriteDog favoriteDog)async{
    Database db = await mDatabase();
    var id = await db.insert('FAVORITES', favoriteDog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
     var list = await getFavorites(id);
     print('$list dgdddddddddddddđ');
    return id;
  }
  static Future<void> removeFavorite(int dogId,String userId)async{
    Database db = await mDatabase();
    await db.delete("FAVORITES",
      where: 'dogId = ? AND userId = ?',
      whereArgs: [dogId, userId],);
  }
  static Future<List<Dog>> getListFavoriteDog(String userId)async{
    Database db = await mDatabase();
    List<Dog> dogs= [];
    try {
      var list = await db.query(
        'FAVORITES',
        where: 'userId = ?',
        whereArgs: [userId],
      );
      for (var item in list) {
        FavoriteDog favoriteDog = FavoriteDog.fromJson(item);
        dogs.add(favoriteDog.dog);
      }
    } catch (e) {
      print('Error fetching favorite dogs: $e');
    }
    //print(dogs);
    return dogs;
  }
  static Future<List<dynamic>> getFavorites(int id)async{
    Database db = await mDatabase();
    var list = db.query('FAVORITES',
      where: 'Id = ?',
      whereArgs: [id],);
    return list;
  }
  static Future<bool> isFavoriteExist(int dogId, String userId) async {
    Database db = await mDatabase();
    var count = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM FAVORITES WHERE dogId = ? AND userId = ?',
      [dogId, userId],
    ));
    return count! > 0;
  }
}