import 'dart:async';
import 'package:agrib/knowledgeup/knowledgeup.dart';
import 'package:flutter/material.dart';
import 'package:agrib/common/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:agrib/updateme/updatebest.dart';
import 'package:agrib/updateme/updateme.dart';

class UpdateList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UpdateListState();
  }
}

class UpdateListState extends State<UpdateList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<UpdateMe> updateList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (updateList == null) {
      updateList = List<UpdateMe>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Alert'),
      ),
      body: getUpdateListView(),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(UpdateMe('', '',''), 'Add My Fair');
        },
        tooltip: 'Add My Fair',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  ListView getUpdateListView() {
    debugPrint("mmmmmmmmmmmmmmmmm"+count.toString());
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
         //debugPrint("xxxy p"+this.updateList[position].toString());
         debugPrint("xxxy id"+this.updateList[position].id.toString());
         debugPrint("xxxy ti"+this.updateList[position].title.toString());
        debugPrint("xxxy desi"+this.updateList[position].description.toString());
        // debugPrint("xxxy des2"+this.todoList[position].priority.toString());
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
             leading: CircleAvatar(
               backgroundColor: Colors.red,
               child: Icon(Icons.add_alert_outlined,size: 25,color: Colors.black),
             ),
            title: Text(this.updateList[position].title.toString(),
                style: TextStyle(fontWeight: FontWeight.bold)),
            //subtitle: Text((this.updateList[position].date.toString()).toString()+' LKR'),
            subtitle: Text(this.updateList[position].description,style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Text((this.updateList[position].date.toString()).toString()),
                  onTap: () {
                  //  _delete(context, updateList[position]);
                  },
                ),
              ],
            ),

            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetail(this.updateList[position], 'Edit My Fair');
            },
          ),
        );
      },
    );
  }

  getFirstLetter(String title) {
    return title.substring(0, 2);
  }

  void _delete(BuildContext context, UpdateMe todoupdate) async {
    int result = await databaseHelper.deleteTodoUpdate(todoupdate.id);
    if (result != 0) {
      _showSnackBar(context, 'My Fair Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(UpdateMe todoupdate, String title) async {
    //bool result=false;
    debugPrint("xddxxy"+todoupdate.id.toString());
    //if (todo.id != null) {
    print("aaaa");
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UpdateBest(todoupdate, "aaaaaa");
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
      Future<List<UpdateMe>> todoListFuture = databaseHelper.getTodoListUpdate();
      todoListFuture.then((todoList) {
        setState(() {
          this.updateList = todoList;
          debugPrint("rrrr"+todoList.length.toString());
          this.count = todoList.length;
        });
      });
    });
  }


}