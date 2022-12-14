import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:agrib/updateme/updateme.dart';

class DatabaseHelperUpdateListRemove {

  static DatabaseHelperUpdateListRemove _databaseHelperUpdateList;    // Singleton DatabaseHelper
  static Database _databaseupdate;                // Singleton Database

  String updatemeTable = 'updateme_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';
  String colPriority = 'priority';
  String todoTable = 'todo_table';
  //String colPriority = 'priority';

  DatabaseHelperUpdateListRemove._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelperUpdateListRemove() {

    if (_databaseHelperUpdateList == null) {
      _databaseHelperUpdateList = DatabaseHelperUpdateListRemove._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelperUpdateList;
  }

  Future<Database> get database async {

    if (_databaseupdate == null) {
      _databaseupdate = await initializeDatabase();
    }
    return _databaseupdate;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    print("fath"+directory.path);
    String path = directory.path + 'todos.db';

    // Open/create the database at a given path
    var todosDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return todosDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $updatemeTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colDate TEXT)');
    await db.execute('CREATE TABLE $todoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colDate TEXT, $colPriority INTEGER)');

  }

  // Fetch Operation: Get all todo objects from database
  Future<List<Map<String, dynamic>>> getUpdateMeMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(updatemeTable, orderBy: '$colTitle ASC');
    return result;
  }

  // Insert Operation: Insert a todo object to database
  Future<int> insertTodo(UpdateMe todoupdate) async {
    Database db = await this.database;
    //debugPrint("hai"+todoupdate.priority.toString());
    debugPrint("hai2"+todoupdate.title.toString());
    debugPrint("hai9"+todoupdate.description.toString());
    debugPrint("hai9"+todoupdate.date.toString());
    var result = await db.insert(updatemeTable, todoupdate.toMap());
    debugPrint("haires "+result.toString());
    return result;
  }

  // Update Operation: Update a todo object and save it to database
  Future<int> updateTodo(UpdateMe todoupdate) async {
    var db = await this.database;
    var result = await db.update(updatemeTable, todoupdate.toMap(), where: '$colId = ?', whereArgs: [todoupdate.id]);
    return result;
  }


  // Delete Operation: Delete a todo object from database
  Future<int> deleteTodo(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $updatemeTable WHERE $colId = $id');
    return result;
  }

  // Get number of todo objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $updatemeTable');
    int result = Sqflite.firstIntValue(x);
    debugPrint("count here is "+result.toString());
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
  Future<List<UpdateMe>> getTodoList() async {

    var updatemeMapList = await getUpdateMeMapList(); // Get 'Map List' from database
    int count = updatemeMapList.length;         // Count the number of map entries in db table

    List<UpdateMe> todoList = List<UpdateMe>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      todoList.add(UpdateMe.fromMapObject(updatemeMapList[i]));
    }

    return todoList;
  }

}