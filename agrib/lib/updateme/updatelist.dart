import 'dart:async';
import 'package:agrib/common/dashboard.dart';
import 'package:agrib/common/route_controller.dart';
import 'package:agrib/knowledgeup/knowledgeup.dart';
import 'package:agrib/updateme/updateme_controller.dart';
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
  UpdateMeController updatemeController=new UpdateMeController();
  RouteCommon routeController= new RouteCommon();

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
          routeController.navigateToHome(this.context);;
        },
        tooltip: 'Add My Fair',
        child: Icon(Icons.home),
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
            subtitle: Text(this.updateList[position].description,style: TextStyle(fontWeight: FontWeight.normal)),
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

            // onTap: () {
            //   debugPrint("ListTile Tapped");
            //   navigateToDetail(this.updateList[position], 'Edit My Fair');
            // },
          ),
        );
      },
    );
  }

  getFirstLetter(String title) {
    return title.substring(0, 2);
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