import 'package:agrib/bestfit/bestfit.dart';
import 'package:agrib/knowledgeup/knowledge.dart';
import 'package:agrib/services/updateme_api_service.dart';
import 'package:agrib/updateme/updatebest.dart';
import 'package:agrib/updateme/updateme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'common/dashboard.dart';
import 'common/database_helper.dart';
import 'dart:async';
import 'dart:io';

void main() async{

  fetchOfflineData();
  runApp(
      AgribApp()
  );
}

class AgribApp extends StatelessWidget {

  AgribApp();

  @override
  Widget build(BuildContext context) {

    var internetconnection_check;
    return MaterialApp(
      title: 'Agri Buddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: MyGridScreen(),
    );
  }


}

void fetchOfflineData() async {

  var internetconnection = await isConnected();

  if(internetconnection==true){
    DatabaseHelper helper = new DatabaseHelper();
    NetworkHelper networkHelper = NetworkHelper();
    //Update Me Online Syncing
    int count_updateme = await helper.getLastIdUpdateMe();
    print("counttt"+count_updateme.toString());
    var decodedResp = await networkHelper.getData(count_updateme.toString());
    print(decodedResp);
    if(decodedResp != null) {
      print("oppsupdate" + decodedResp.length.toString());
      UpdateMe todoupdate = new UpdateMe("", "", "");
      for (var i = 0; i < decodedResp.length; i++) {
        int result;
        UpdateMe todoupdate = new UpdateMe("", "", "");
        todoupdate.title = decodedResp[i]['title'];
        todoupdate.description = decodedResp[i]['description'];
        todoupdate.date = decodedResp[i]['date'];
        result = await helper.insertTodoUpdate(todoupdate);
      }
    }else{
      print("It is null");
    }

    //Knowledgeup online syncing
    int count_knowledgeup = await helper.getLastIdKnowledgeup();
    print("counttt knowledge up"+count_knowledgeup.toString());
    var decodedRespKnowledge = await networkHelper.getDataKnowledgeUp(count_knowledgeup.toString());
    print(decodedRespKnowledge);
    if(decodedRespKnowledge != null) {
      print("oppsknowle" + decodedRespKnowledge.length.toString());
      Knowledge todoknowledge = new Knowledge("", "", "","");
      for (var i = 0; i < decodedRespKnowledge.length; i++) {
        int result;
        Knowledge todoknowledge = new Knowledge("", "", "","");
        todoknowledge.title = decodedRespKnowledge[i]['title'];
        todoknowledge.description = decodedRespKnowledge[i]['description'];
        todoknowledge.author = decodedRespKnowledge[i]['description'];
        todoknowledge.date = decodedRespKnowledge[i]['date'];
        result = await helper.insertTodoKnowledge(todoknowledge);
      }
    }else{
      print("It is null knowledgeup");
    }

    //Bestfit Online sync
    int count_bestfit = await helper.getLastIdBestFit();
    print("counttt bestfit"+count_bestfit.toString());
    var decodedRespBestFit = await networkHelper.getDataBestFit(count_bestfit.toString());
    print(decodedRespBestFit);
    if(decodedRespBestFit != null) {

      print("oppsbest" + decodedRespBestFit.length.toString());
      BestFit todobestfit = new BestFit("", "", "","",0,"","");
      for (var i = 0; i < decodedRespBestFit.length; i++) {
        int result;
        BestFit todobestfit = new BestFit("", "", "","",0,"","");
        todobestfit.maincrop = decodedRespBestFit[i]['maincrop'];
        todobestfit.landscape = decodedRespBestFit[i]['landscape'];
        todobestfit.soil = decodedRespBestFit[i]['soil'];
        todobestfit.rain = decodedRespBestFit[i]['rain'];
        todobestfit.crop = decodedRespBestFit[i]['crop'];
        todobestfit.title = int.parse(decodedRespBestFit[i]['title']);
        todobestfit.description = decodedRespBestFit[i]['description'];
        result = await helper.insertTodo(todobestfit);
      }
    }else{
      print("It is null bestfit");
    }


  }else{

        }
}


Future<bool> isConnected() async {
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


