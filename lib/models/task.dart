import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../helper.dart';

class Task {
  static String _tableName = 'tasks';

  int id;
  String title;
  String status = 'incomplete';

  Task({this.id, this.title, this.status});

  void changeStatus(String s) {
    status = s;
  }

  Widget getIcon() {
    if (this.status == 'completed') {
      return Icon(
        Icons.check,
        color: Colors.green[400],
      );
    }
    if (this.status == 'later') {
      return Icon(
        Icons.arrow_right_alt_sharp,
        color: Colors.blue[400],
      );
    }
    if (this.status == 'cancelled') {
      return Icon(
        Icons.close,
        color: Colors.red[400],
      );
    }
    return Icon(
      Icons.check_box_outline_blank,
      color: Colors.grey[400],
    );
  }

  save() async {
    await Helper.db.insert(
      _tableName,
      this._toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Map<String, dynamic> _toMap() {
    return {
      'id': id,
      'title': title,
      'status': status,
    };
  }

  static Future<List<Task>> getAll() async {
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> data = await Helper.db.query(_tableName);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(data.length, (i) {
      return Task(
        id: data[i]['id'],
        title: data[i]['title'],
        status: data[i]['status'],
      );
    });
  }

  void delete() async {
    await Helper.db.delete(
      _tableName,
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
