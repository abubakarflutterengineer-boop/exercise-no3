import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper.singleton();
  static final DbHelper instance = DbHelper.singleton();
  factory DbHelper() {
    return instance;
  }
  static Database? _db;
  static const String tableName = 'Student';
  Future<Database> db() async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String dbPath = join(directory.path, 'Student.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (database, version) async {
        await database.execute('''
          CREATE TABLE $tableName (
            Id INTEGER PRIMARY KEY AUTOINCREMENT,
            Name TEXT,
            rollNo TEXT,
            department TEXT,
            marks INTEGER
          )
          ''');
      },
    );
  }

  Future<int> insertStudent({
    required String name,
    required String rollNo,
    required String department,
    required int marks,
  }) async {
    final Database database = await db();
    final Map<String, dynamic> student = {
      'Name': name,
      'rollNo': rollNo,
      'department': department,
      'marks': marks,
    };
    return await database.insert(tableName, student);
  }

  Future<List<Map<String, dynamic>>> getAllStudents() async {
    final Database database = await db();
    return await database.query(tableName, orderBy: 'Id DESC');
  }

  Future<Map<String, dynamic>?> getStudentById(int id) async {
    final Database database = await db();
    final List<Map<String, dynamic>> students = await database.query(
      tableName,
      where: 'Id = ?',
      whereArgs: [id],
    );
    if (students.isEmpty) {
      return null;
    }
    return students.first;
  }

  Future<int> updateStudent({
    required int id,
    required String name,
    required String rollNo,
    required String department,
    required int marks,
  }) async {
    final Database database = await db();
    final Map<String, dynamic> student = {
      'Name': name,
      'rollNo': rollNo,
      'department': department,
      'marks': marks,
    };
    final int result = await database.update(
      tableName,
      student,
      where: 'Id = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<int> deleteStudent(int id) async {
    final Database database = await db();
    return await database.delete(tableName, where: 'Id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllStudents() async {
    final Database database = await db();
    return await database.delete(tableName);
  }
}
