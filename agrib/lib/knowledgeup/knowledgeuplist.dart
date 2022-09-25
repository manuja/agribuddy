import 'dart:async';
import 'package:agrib/common/route_controller.dart';
import 'package:agrib/knowledgeup/knowledge.dart';
import 'package:agrib/knowledgeup/knowledgeup.dart';
import 'package:agrib/knowledgeup/knowledgeup_controller.dart';
import 'package:flutter/material.dart';
import 'package:agrib/bestfit/bestfit.dart';
import 'package:agrib/common/database_helper.dart';
import 'package:agrib/bestfit/searchbest.dart';
import 'package:sqflite/sqflite.dart';

import 'knowledgeup_detail.dart';

class KnowledgeupList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return KnowledgeupListState();
  }
}

class KnowledgeupListState extends State<KnowledgeupList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  RouteCommon routeController= new RouteCommon();
  KnowledgUpController knowledgeupController=new KnowledgUpController();
  List<Knowledge> knowledgeList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (knowledgeList == null) {
      knowledgeList = List<Knowledge>();
      getListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Article List'),
      ),
      body: getKnowledgeTodoListView(),
      bottomNavigationBar: BottomAppBar(
        color:Colors.white,
        shape: CircularNotchedRectangle(), //shape of notch
        notchMargin: 5, //notche margin between floating button and bottom appbar
        child: Row( //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.home_rounded, color: Colors.blueAccent,size:38), onPressed: () {routeController.navigateToHome(this.context);} , padding: EdgeInsets.only(top: 0.0, left: 70.0), ),
            IconButton(icon: Icon(Icons.settings_backup_restore_rounded, color: Colors.blueAccent,size:38), onPressed: () {routeController.navigateToHome(this.context);}, padding: EdgeInsets.only(top: 0.0, right: 70.0),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         // debugPrint('FAB clicked');
          knowledgeupController.navigateToSearch(Knowledge('', '', '', ''), 'Search Article',context);
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
        debugPrint("xxxy au"+this.knowledgeList[position].author.toString());
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(getFirstLetter(this.knowledgeList[position].title.toString()),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text((this.knowledgeList[position].title.toString()),
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("by "+this.knowledgeList[position].author.toString(),
                style: TextStyle(fontWeight: FontWeight.bold)
            ),
            //subtitle: Text(this.todoList[position].description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Text(this.knowledgeList[position].date.toString()),
                  // onTap: () {
                  //  // _delete(context, todoList[position]);
                  // },
                ),
              ],
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              knowledgeupController.navigateToDetail(this.knowledgeList,this.knowledgeList[position], 'Article',context,"1");
            },
          ),
        );
      },
    );
  }

  getFirstLetter(String title) {
    return title.substring(0, 1);
  }


  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
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

  void getListView() {
    print("here it.....................");
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


}