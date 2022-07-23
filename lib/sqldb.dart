import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'bankingApp.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade ===========================================");
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute('''
    CREATE TABLE "user" (
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
      "name" TEXT NOT NULL,
      "balance" INTEGER NOT NULL, 
      "email" EMAIL NOT NULL
      
    )
    ''');
    batch.execute('''
    CREATE TABLE "transfers" (
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
      "sender" TEXT NOT NULL, 
      "senderId" INTEGER NOT NULL, 
      "receiver" TEXT NOT NULL,
      "receiverId" INTEGER NOT NULL,
      "amount" INTEGER NOT NULL,
      "time" DATETIME NOT NULL
    )
    ''');
    await batch.commit();
    print("onCreate ===========================================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  readUserData(
    String sql,
  ) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  mydeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'bankingApp.db');
    await deleteDatabase(path);
  }

  // SHORTCUTS FUNCTIONS ================

  read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }

  update(String table, Map<String, Object?> values, String? mywhere) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, values, where: mywhere);
    return response;
  }

  delete(String table, String? mywhere) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table, where: mywhere);
    return response;
  }
}
