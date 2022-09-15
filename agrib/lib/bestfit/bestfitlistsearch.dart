import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agrib/bestfit/bestfit.dart';
import 'package:agrib/common/database_helper.dart';
import 'package:agrib/bestfit/searchbest.dart';
import 'package:sqflite/sqflite.dart';

class BestFitListSearch extends StatefulWidget {

  final String appBarTitle;
  final BestFit todo;

  BestFitListSearch(this.todo, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return BestFitListSearchState(this.todo, this.appBarTitle);
  }
}

class BestFitListSearchState extends State<BestFitListSearch> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<BestFit> todoList;
  BestFit todo;
  String appBarTitle;
  int count = 0;

  BestFitListSearchState(this.todo, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    if (todoList == null) {
      todoList = List<BestFit>();
      //updateListView();
      getListView(todo);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Best Fit List'),
      ),
      body: getTodoListView(),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(BestFit('', '', '','',0,'',''), 'Add My Fair');
        },
        tooltip: 'Add My Fair',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  ListView getTodoListView() {
    debugPrint("mmmmmmmmmmmmmmmmm"+count.toString());
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        debugPrint("xxxy p"+this.todoList[position].toString());
        debugPrint("xxxy id"+this.todoList[position].id.toString());
        debugPrint("xxxy ti"+this.todoList[position].title.toString());
        debugPrint("xxxy des"+this.todoList[position].description.toString());
        debugPrint("xxxy des2"+this.todoList[position].soil.toString());
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(this.todoList[position].title.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.todoList[position].description.toString()+" - ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text((this.todoList[position].rain.toString()).toString()+' mmmm'),
            //subtitle: Text(this.todoList[position].description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.delete,color: Colors.red,),
                  onTap: () {
                    _delete(context, todoList[position]);
                  },
                ),
              ],
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetail(this.todoList[position], 'Edit My Fair');
            },
          ),
        );
      },
    );
  }

  getFirstLetter(String title) {
    return title.substring(0, 2);
  }

  void _delete(BuildContext context, BestFit todo) async {
    int result = await databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      _showSnackBar(context, 'My Fair Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(BestFit todo, String title) async {
    //bool result=false;
    debugPrint("xddxxy"+todo.id.toString());
    //if (todo.id != null) {
    print("aaaa");
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SearchBest(todo, "aaaaaa");
    }));

    //}else{
    print("aass");
    //}


    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<BestFit>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((todoList) {
        setState(() {
          this.todoList = todoList;
          debugPrint("rrrr"+todoList.length.toString());
          this.count = todoList.length;
        });
      });
    });
  }

  void getListView(BestFit todo) {
    print("here it.....................");
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<BestFit>> todoListFuture = databaseHelper.getTodoListSearch(todo);
      todoListFuture.then((todoList) {
        setState(() {
          this.todoList = todoList;
          debugPrint("rrrr"+todoList.length.toString());
          this.count = todoList.length;
        });
      });
    });
  }


}