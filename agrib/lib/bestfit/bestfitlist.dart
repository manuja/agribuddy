import 'dart:async';
import 'package:agrib/bestfit/bestfit_controller.dart';
import 'package:agrib/common/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:agrib/bestfit/bestfit.dart';
import 'package:agrib/common/database_helper.dart';
import 'package:agrib/bestfit/searchbest.dart';
import 'package:sqflite/sqflite.dart';
import 'package:agrib/common/route_controller.dart';

import '../main.dart';

class BestFitList extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return BestFitListState();
  }
}

class BestFitListState extends State<BestFitList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  RouteCommon routeController= new RouteCommon();
  BestFitController bestFitController=new BestFitController();
  List<BestFit> todoList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (todoList == null) {
      todoList = List<BestFit>();
      this.updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Best Fit List'),
      ),
      body: getTodoListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bestFitController.navigateToDetail(BestFit('', '', '','',0,'',''), 'Search Best Fit',context);
        },
        tooltip: 'Search',
        child: Icon(Icons.search),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              bestFitController.navigateToDetail(this.todoList[position], 'Edit My List',context);
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



}