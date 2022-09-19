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
    int count_updateme = await helper.getLastIdUpdateMe();
    print("counttt"+count_updateme.toString());
    var decodedResp = await networkHelper.getData(count_updateme.toString());
    print(decodedResp);
    if(decodedResp != null) {
      print("opps" + decodedResp.length.toString());
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
      //return
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


