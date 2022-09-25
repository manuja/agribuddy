import 'dart:async';
import 'package:agrib/common/route_controller.dart';
import 'package:flutter/material.dart';
import 'package:agrib/bestfit/bestfit.dart';
import 'package:agrib/common/database_helper.dart';
import 'package:agrib/bestfit/searchbest.dart';
import 'package:sqflite/sqflite.dart';

import 'bestfit_controller.dart';

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
  RouteCommon routeController= new RouteCommon();
  BestFitController bestFitController=new BestFitController();
  List<BestFit> todoList;
  BestFit todo;
  String appBarTitle;
  int count = 0;

  BestFitListSearchState(this.todo, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    if (todoList == null) {
      todoList = List<BestFit>();
      getListView(todo);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Best Fit List Search Result'),
      ),
      body: getTodoListView(),
      bottomNavigationBar: BottomAppBar(
        color:Colors.white,
        shape: CircularNotchedRectangle(), //shape of notch
        notchMargin: 5, //notche margin between floating button and bottom appbar
        child: Row( //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.home_rounded, color: Colors.blueAccent,size:38), onPressed: () {routeController.navigateToHome(this.context);} , padding: EdgeInsets.only(top: 0.0, left: 70.0), ),
            IconButton(icon: Icon(Icons.settings_backup_restore_rounded, color: Colors.blueAccent,size:38), onPressed: () {routeController.navigateToBestFitList(this.context);}, padding: EdgeInsets.only(top: 0.0, right: 70.0),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          bestFitController.navigateToDetail(BestFit('', '', '','',0,'',''), 'Search Best Fit',context);
        },
        tooltip: 'Add My Fair',
        child: Icon(Icons.search),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  ListView getTodoListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {

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
            subtitle: Text((this.todoList[position].description.toString()).substring(0,15)+"....."),
            //subtitle: Text(this.todoList[position].description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
            ),
            onTap: () {
              //bestFitController.navigateToDetail(this.todoList[position], 'Edit My Fair',context);
              bestFitController.navigateToDetailDescription(this.todoList[position], 'Detail Description Of Best Fit',context,"2");
            },
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
      Future<List<BestFit>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((todoList) {
        setState(() {
          this.todoList = todoList;
          this.count = todoList.length;
        });
      });
    });
  }

  void getListView(BestFit todo) {
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