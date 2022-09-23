
import 'dart:io';

import 'package:agrib/bestfit/bestfitlist.dart';
import 'package:agrib/bestfit/searchbest.dart';
import 'package:agrib/common/database_helper.dart';
import 'package:agrib/common/route_controller.dart';
import 'package:agrib/knowledgeup/knowledgeuplist.dart';
import 'package:agrib/updateme/updatelist.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'bestfit.dart';
import 'bestfitlistsearch.dart';


class BestFitController{

  DatabaseHelper databaseHelper = DatabaseHelper();
  RouteCommon routeController= new RouteCommon();

  void navigateToDetail(BestFit todo, String title, context) async {

    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SearchBest(todo, title);
    }));
    if (result == true) {
      //updateListView();
    }
  }

  void moveToLastScreen(context) {
    Navigator.pop(context, true);
  }

  // Search data in database
  void search(context,todo) async {

    //if (todo.id != null) {
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BestFitListSearch(todo, "Search List");
    }));
    //}else{
    //}
    // if (result == true) {
    //   updateListView();
    // }

  }

  Future<bool> isConnected() async {
    print("goosd");
    try {
      List<InternetAddress> result = await InternetAddress.lookup('google.com')
          .timeout(Duration(seconds: 5));

      //
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      //
      else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }




}