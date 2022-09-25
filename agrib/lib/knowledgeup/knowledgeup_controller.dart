import 'package:agrib/bestfit/bestfitlist.dart';
import 'package:agrib/knowledgeup/knowledgeuplist.dart';
import 'package:agrib/updateme/updatelist.dart';
import 'package:flutter/material.dart';

import 'knowledge.dart';
import 'knowledgeup.dart';
import 'knowledgeup_detail.dart';
import 'knowledgeuplistsearch.dart';

class KnowledgUpController{

  void navigateToSearch(Knowledge knowtodo, String title,context) async {
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
     // updateListView();
    }
  }

  void navigateToDetail(List<Knowledge> knowlist,Knowledge knowtodo, String title,context,String tag) async {
    //bool result=false;
    debugPrint("xddxxy"+knowlist.toString());
    //if (todo.id != null) {
    print("aaaa");
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return KnowledgeUpDetail(knowtodo, title,tag);
    }));

    //}else{
    print("aass");
    //}


    if (result == true) {
      //updateListView();
    }
  }

  void search(todoknowledge,context) async {

    print("welcome to search"+todoknowledge.title);

    //moveToLastScreen();
    //bool result=false;
    //debugPrint("xddxxy"+knowtodo.id.toString());
    //if (todo.id != null) {
    print("aaaa");
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return KnowledgeupListSearch(todoknowledge, "aaaaaa");
    }));

    //}else{
    print("aass");
    //}


    // if (result == true) {
    //   updateListView();
    // }


  }


}