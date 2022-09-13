import 'package:agrib/knowledgeup/knowledge.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:agrib/bestfit/bestfit.dart';
import 'package:agrib/updateme/updateme.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String todoTable = 'todo_table';
  String updatemeTable = 'updateme_table';
  String knowledgeupTable= 'knowledgeup_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';
  String colPriority = 'priority';
  String colAuthor= 'author';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
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

    await db.execute('CREATE TABLE $todoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colDate TEXT, $colPriority INTEGER)');
    await db.execute('CREATE TABLE $updatemeTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colDate TEXT)');
    await db.execute('CREATE TABLE $knowledgeupTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colAuthor TEXT, $colDate TEXT)');
  }

  // Fetch Operation: Get all todo objects from database
  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(todoTable, orderBy: '$colTitle ASC');
    return result;
  }

  // Fetch Operation: Get all todo objects from database
  Future<List<Map<String, dynamic>>> getUpdateMeMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(updatemeTable, orderBy: '$colTitle ASC');
    return result;
  }

  // Fetch Operation: Get all todo objects from database
  Future<List<Map<String, dynamic>>> getKnowledgeMapList() async {
    Database db = await this.database;

		//var result = await db.rawQuery('SELECT * FROM $knowledgeupTable WHERE $colTitle LIKE "%c%" order by $colTitle ASC');
    var result = await db.query(knowledgeupTable, orderBy: '$colTitle ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getKnowledgeMapListSearch(String keyword) async {
    Database db = await this.database;
    print("keep it....................."+keyword);
    var result = await db.rawQuery('SELECT * FROM $knowledgeupTable WHERE $colTitle LIKE ?',["%"+keyword+"%"]);
   // var result = await db.rawQuery('SELECT * FROM $knowledgeupTable WHERE $colTitle LIKE "%d%" order by $colTitle ASC');
    // var result = await db.query(knowledgeupTable, orderBy: '$colTitle ASC');
   // String sql = String.format("select col1 from table where col2=%s and col3=%s","value for col2", "value for col3");
   // Cursor cc = db.rawQuery(sql, null);

    //DB::select('select * from test where mid=? and created>? where id=5 group by type', [$member, $from] )
    return result;
  }

  // Insert Operation: Insert a todo object to database
  Future<int> insertTodo(BestFit todo) async {
    Database db = await this.database;
    debugPrint("hai"+todo.priority.toString());
    debugPrint("hai2"+todo.title.toString());
    debugPrint("hai9"+todo.description.toString());
    var result = await db.insert(todoTable, todo.toMap());
    debugPrint("haires "+result.toString());
    return result;
  }
  // Insert Operation: Insert a todo object to database
  Future<int> insertTodoUpdate(UpdateMe todoupdate) async {
    Database db = await this.database;
    //debugPrint("hai"+todoupdate.priority.toString());
    debugPrint("hai2"+todoupdate.title.toString());
    debugPrint("hai9"+todoupdate.description.toString());
    debugPrint("hai9"+todoupdate.date.toString());
    var result = await db.insert(updatemeTable, todoupdate.toMap());
    debugPrint("haires "+result.toString());
    return result;
  }

  // Insert Operation: Insert a todo object to database
  Future<int> insertTodoKnowledge(Knowledge todoknowledge) async {
    Database db = await this.database;
    //debugPrint("hai"+todoupdate.priority.toString());
    debugPrint("hai2"+todoknowledge.title.toString());
    debugPrint("hai9"+todoknowledge.description.toString());
    debugPrint("hai9"+todoknowledge.author.toString());
    debugPrint("hai9"+todoknowledge.date.toString());
    var result = await db.insert(knowledgeupTable, todoknowledge.toMap());
    debugPrint("haires "+result.toString());
    return result;
  }

  // Update Operation: Update a todo object and save it to database
  Future<int> updateTodo(BestFit todo) async {
    var db = await this.database;
    var result = await db.update(todoTable, todo.toMap(), where: '$colId = ?', whereArgs: [todo.id]);
    return result;
  }

  // Update Operation: Update a todo object and save it to database
  Future<int> updateTodoUpdate(UpdateMe todoupdate) async {
    var db = await this.database;
    var result = await db.update(updatemeTable, todoupdate.toMap(), where: '$colId = ?', whereArgs: [todoupdate.id]);
    return result;
  }

  Future<int> updateTodoKnowledge(Knowledge todoknowledge) async {
    var db = await this.database;
    var result = await db.update(knowledgeupTable, todoknowledge.toMap(), where: '$colId = ?', whereArgs: [todoknowledge.id]);
    return result;
  }


  // Delete Operation: Delete a todo object from database
  Future<int> deleteTodo(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $todoTable WHERE $colId = $id');
    return result;
  }

  // Delete Operation: Delete a todo object from database
  Future<int> deleteTodoUpdate(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $updatemeTable WHERE $colId = $id');
    return result;
  }

  // Delete Operation: Delete a todo object from database
  Future<int> deleteTodoKnowledge(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $updatemeTable WHERE $colId = $id');
    return result;
  }

  // Get number of todo objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $todoTable');
    int result = Sqflite.firstIntValue(x);
    debugPrint("count here is "+result.toString());
    return result;
  }

  // Get number of todo objects in database
  Future<int> getCountUpdate() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $updatemeTable');
    int result = Sqflite.firstIntValue(x);
    debugPrint("count here is "+result.toString());
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
  Future<List<BestFit>> getTodoList() async {

    var todoMapList = await getTodoMapList(); // Get 'Map List' from database
    int count = todoMapList.length;         // Count the number of map entries in db table

    List<BestFit> todoList = List<BestFit>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      todoList.add(BestFit.fromMapObject(todoMapList[i]));
    }

    return todoList;
  }
  // Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
  Future<List<UpdateMe>> getTodoListUpdate() async {

    var updatemeMapList = await getUpdateMeMapList(); // Get 'Map List' from database
    int count = updatemeMapList.length;         // Count the number of map entries in db table

    List<UpdateMe> todoList = List<UpdateMe>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      todoList.add(UpdateMe.fromMapObject(updatemeMapList[i]));
    }

    return todoList;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
  Future<List<Knowledge>> getTodoListKnowledge() async {

    var knowledgeMapList = await getKnowledgeMapList(); // Get 'Map List' from database
    int count = knowledgeMapList.length;         // Count the number of map entries in db table

    List<Knowledge> todoList = List<Knowledge>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      todoList.add(Knowledge.fromMapObject(knowledgeMapList[i]));
    }

    return todoList;
  }

  Future<List<Knowledge>> getTodoListKnowledgeSearch(String keyword) async {

    var knowledgeMapList = await getKnowledgeMapListSearch(keyword); // Get 'Map List' from database
    int count = knowledgeMapList.length;         // Count the number of map entries in db table

    List<Knowledge> todoList = List<Knowledge>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      todoList.add(Knowledge.fromMapObject(knowledgeMapList[i]));
    }

    return todoList;
  }

}