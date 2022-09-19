import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agrib/bestfit/bestfit.dart';
import 'package:agrib/common/database_helper.dart';
import 'package:agrib/bestfit/searchbest.dart';
import 'package:sqflite/sqflite.dart';

class BestFitList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BestFitListState();
  }
}

class BestFitListState extends State<BestFitList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<BestFit> todoList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (todoList == null) {
      todoList = List<BestFit>();
      updateListView();
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
          navigateToDetail(BestFit('', '', '','',0,'',''), 'Search Best Fit');
        },
        tooltip: 'Search',
        child: Icon(Icons.search),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }

  ListView getTodoListView() {
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
              child: Text(getFirstLetter(this.todoList[position].maincrop.toString()),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.todoList[position].crop.toString(),
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text((this.todoList[position].description.toString()).toString()),
            //subtitle: Text(this.todoList[position].description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              // children: <Widget>[
              //   GestureDetector(
              //     child: Icon(Icons.delete,color: Colors.red,),
              //     onTap: () {
              //       _delete(context, todoList[position]);
              //     },
              //   ),
              // ],
            ),
            onTap: () {
              navigateToDetail(this.todoList[position], 'Edit My List');
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
      _showSnackBar(context, 'My List Deleted Successfully');
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
     // print("aaaa");
      bool result =
      await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SearchBest(todo, title);
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


}