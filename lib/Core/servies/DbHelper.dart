import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nspo/Core/models/AttendanceRecord.dart';
import 'package:intl/intl.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'AttendencesOffline.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE AttendanceRecord (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        personId INTEGER ,
        latitude REAL,
        longitude REAL,
        deviceId TEXT,
        isMiddleDay INTEGER,
        attDate TEXT,
        inOut INTEGER,
        isSent  INTEGER
      )
    ''');
  }

  Future<int> insertAttendance(AttendanceRecord attendance) async {
    Database db = await database;
    return await db.insert('AttendanceRecord', attendance.toMap());
  }

  Future<List<AttendanceRecord>> getAttendances(int personId) async {
    Database db = await database;

    List<Map<String, dynamic>> maps = await db.query('AttendanceRecord',
        where: 'personId = ? AND isSent = 0', whereArgs: [personId]);
    return List.generate(maps.length, (i) {
      return AttendanceRecord.fromMap(maps[i]);
    });
  }

  Future<List<Map>> getAttendancesToday(int personId) async {
    Database db = await database;
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    List<Map<String, dynamic>> maps = await db.query('AttendanceRecord',
        where: 'personId = ? AND DATE(attDate) = ?',
        whereArgs: [personId, formattedDate]);

    return maps;
  }

  // only update attdate
  Future<int> updateAttendance(int id, String newDateTime) async {
    Database db = await database;
    return await db.update(
      'AttendanceRecord',
      {'attDate': newDateTime},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int?> checkIfLeave(AttendanceRecord attendance) async {
    Database db = await database;
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(attendance.attDate!));

    List<Map<String, dynamic>> maps = await db.query(
      'AttendanceRecord',
      columns: ['id'],
      where: 'personId = ? AND DATE(attDate) = DATE(?) AND inOut = 1',
      whereArgs: [attendance.personId, formattedDate],
    );

    if (maps.isNotEmpty) {
      return maps.first['id'] as int; // Return the id if found
    } else {
      return null; // Return null if not found
    }
  }

  delete(int id) async {
    Database db = await database;
    await db.delete('AttendanceRecord', where: 'id = ?', whereArgs: [id]);
  }

  Future updateSent(int id) async {
    Database db = await database;
    await db.update('AttendanceRecord', {'isSent': 1},
        where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    Database db = await database;
    db.close();
  }

  // getcountIsNotSent
  Future<int> getCountIsNotSent(int personId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('AttendanceRecord',
        where: 'personId = ? AND isSent = 0', whereArgs: [personId]);
    return maps.length;
  }
}
