import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:coffee_shop/data/models/coffee_model.dart';

class DatabaseHelper {
  static Future<Database> _getDb() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, 'favorites.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // The comment that caused the error has been removed.
        await db.execute('''
          CREATE TABLE favorites ( 
            id TEXT PRIMARY KEY, 
            name TEXT,
            imagePath TEXT,
            price REAL,
            description TEXT
          )
          ''');
      },
    );
  }

  static Future<void> addToFavorites(CoffeeModel coffee) async {
    final db = await _getDb();
    await db.insert(
      'favorites',
      coffee.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> removeFromFavorites(String id) async {
    final db = await _getDb();
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<CoffeeModel>> getFavorites() async {
    final db = await _getDb();
    final List<Map<String, dynamic>> maps = await db.query('favorites');

    return List.generate(maps.length, (i) {
      return CoffeeModel.fromMap(maps[i]);
    });
  }
}
