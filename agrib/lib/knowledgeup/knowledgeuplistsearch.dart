import 'dart:async';
import 'package:agrib/knowledgeup/knowledge.dart';
import 'package:agrib/knowledgeup/knowledgeup.dart';
import 'package:flutter/material.dart';
import 'package:agrib/bestfit/bestfit.dart';
import 'package:agrib/common/database_helper.dart';
import 'package:agrib/bestfit/searchbest.dart';
import 'package:sqflite/sqflite.dart';

class KnowledgeupListSearch extends StatefulWidget {

  final String appBarTitle;
  final Knowledge todoknowledge;

  KnowledgeupListSearch(this.todoknowledge, this.appBarTitle);


  @override
  State<StatefulWidget> createState() {
    return KnowledgeupListSearchState(this.todoknowledge, this.appBarTitle);
  }
}

class KnowledgeupListSearchState extends State<KnowledgeupListSearch> {


  //print("serious"+knowledgeList[0].);
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Knowledge> knowledgeList;
  Knowledge todoknowledge;
  String appBarTitle;
  int count = 0;

  KnowledgeupListSearchState(this.todoknowledge, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    if (knowledgeList == null) {
      knowledgeList = List<Knowledge>();
      print("laaaaaawata"+todoknowledge.title);
     // getListView(knowledgeList[0].title);
      getListView(todoknowledge.title);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Knowledge Up List'),
      ),
      body: getKnowledgeTodoListView(),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // debugPrint('FAB clicked');
          navigateToDetail(Knowledge('', '', '', ''), 'Search Article');
        },
        tooltip: 'Add My Fair',
        child: Icon(Icons.search),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  ListView getKnowledgeTodoListView() {
    debugPrint("sujiha"+count.toString());
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        debugPrint("xxxy p"+this.knowledgeList[position].toString());
        debugPrint("xxxy id"+this.knowledgeList[position].id.toString());
        debugPrint("xxxy ti"+this.knowledgeList[position].title.toString());
        debugPrint("xxxy des"+this.knowledgeList[position].description.toString());
        // debugPrint("xxxy des2"+this.todoList[position].priority.toString());
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(getFirstLetter(this.knowledgeList[position].title.toString()),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.knowledgeList[position].title.toString()+" by " + this.knowledgeList[position].author.toString(),
                style: TextStyle(fontWeight: FontWeight.bold)),
            //subtitle: Text((this.todoList[position].priority.toString()).toString()+' LKR'),
            //subtitle: Text(this.todoList[position].description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Text(this.knowledgeList[position].date.toString()),
                  onTap: () {
                    // _delete(context, todoList[position]);
                  },
                ),
              ],
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetail(this.knowledgeList[position], 'Edit My Fair');
            },
          ),
        );
      },
    );
  }

  getFirstLetter(String title) {
    return title.substring(0, 1);
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

  void navigateToDetail(Knowledge knowtodo, String title) async {
    //bool result=false;
    debugPrint("xddxxy"+knowtodo.id.toString());
    //if (todo.id != null) {
    print("aaaa");
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return KnowledgeUp(knowtodo, title);
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
      Future<List<Knowledge>> todoListFuture = databaseHelper.getTodoListKnowledge();
      todoListFuture.then((todoList) {
        setState(() {
          this.knowledgeList = todoList;
          debugPrint("rrrr"+todoList.length.toString());
          this.count = todoList.length;
        });
      });
    });
  }

  void getListView(String keyword) {
    print("here it.....................");
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Knowledge>> todoListFuture = databaseHelper.getTodoListKnowledgeSearch(keyword);
      todoListFuture.then((todoList) {
        setState(() {
          this.knowledgeList = todoList;
          debugPrint("rrrr"+todoList.length.toString());
          this.count = todoList.length;
        });
      });
    });
  }


}