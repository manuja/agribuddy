import 'package:agrib/bestfit/bestfitlist.dart';
import 'package:agrib/knowledgeup/knowledgeuplist.dart';
import 'package:agrib/updateme/updatebest.dart';
import 'package:agrib/updateme/updatelist.dart';
import 'package:agrib/updateme/updateme.dart';
import 'package:flutter/material.dart';

class UpdateMeController{

  void navigateToDetail(UpdateMe todoupdate, String title,context) async {
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
      //updateListView();
    }
  }


}