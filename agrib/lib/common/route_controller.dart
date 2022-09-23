
import 'package:agrib/bestfit/bestfitlist.dart';
import 'package:agrib/knowledgeup/knowledgeuplist.dart';
import 'package:agrib/updateme/updatelist.dart';
import 'package:flutter/material.dart';
import 'dashboard.dart';


class RouteCommon{

  void navigateToHome(context) async {

    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyGridScreen();
    }));

  }

  void navigateToBestFitList(context) async {

    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BestFitList();
    }));

  }

  void navigateToUpdateMe(context) async {

    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UpdateList();
    }));

  }

  void navigateToKnowledgeUpList(context) async {

    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return KnowledgeupList();
    }));

  }
  
}