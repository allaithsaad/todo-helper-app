import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '/models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'tasks';

  static Future<void> initDb() async {
    if (_db != null) {
      log('DB exiet ');
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'task.db';

        // open the database
        _db = await openDatabase(
          _path,
          version: _version,
          onCreate: (Database db, int version) async {
            // When creating the db, create the table
            await db.execute(
              'CREATE TABLE $_tableName ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'title STRING, note TEXT, date STRING, '
              'startTime STRING, endTime STRING, '
              'remind INTEGER, repeat STRING, '
              'color INTEGER, isCompleted INTEGER )',
            );

            log('database Created');
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<int> insert(Task? task) async {
    print('insert function callled');
    return await _db!.insert(_tableName, task!.toJson());
  }

  static Future<int> delete(Task task) async {
    print('delete function callled');
    return await _db!.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('Query function callled');
    return await _db!.query(_tableName);
  }

  static Future<int> update(int id) async {
    print('Update function callled');
    return await _db!.rawUpdate('''
          UPDATE tasks
          SEt isCompleted = ?
          WHERE id = ?
          ''', [1, id]);
  }
}
