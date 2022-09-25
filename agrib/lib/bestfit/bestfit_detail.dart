import 'dart:async';
import 'package:agrib/bestfit/bestfit_controller.dart';
import 'package:agrib/common/route_controller.dart';
import 'package:agrib/knowledgeup/knowledge.dart';
import 'package:agrib/knowledgeup/knowledgeuplistsearch.dart';
import 'package:flutter/material.dart';
import 'package:agrib/bestfit/bestfit.dart';
import 'package:agrib/common/database_helper.dart';
import 'package:intl/intl.dart';

class BestFitDetail extends StatefulWidget {

  final String appBarTitle;
  final BestFit todobestfit;
  final String flag;

  BestFitDetail(this.todobestfit, this.appBarTitle,this.flag);

  @override
  State<StatefulWidget> createState() {

    return BestFitDescriptionState(this.todobestfit, this.appBarTitle,this.flag);
  }

}

class Int {
}

class BestFitDescriptionState extends State<BestFitDetail> {

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  BestFit todobestfit;
  String dropdownvalue = 'Item 1';
  final String flag;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController autherController = TextEditingController();
  BestFitController bestFitController=new BestFitController();
  RouteCommon routeController = new RouteCommon();

  BestFitDescriptionState(this.todobestfit, this.appBarTitle,this.flag);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .title;

    return WillPopScope(

        onWillPop: () {
          moveToLastScreen();
        },

        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(icon: Icon(
                Icons.arrow_back),
                onPressed: () {
                  moveToLastScreen();
                }
            ),
          ),

          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[

                Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text(
                      todobestfit.maincrop.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(top: 0.0, bottom: 25.0),
                    child: Text(
                      todobestfit.crop,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text(
                      todobestfit.description,
                      style: TextStyle(
                        fontSize: 16,
                        //fontWeight: FontWeight.w700,
                      ),
                    )
                ),


                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Finsh Read',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              // _save();
                              if(flag=="1"){
                                routeController.navigateToBestFitList(context);

                              }else{
                                moveToLastScreen();
                              }


                              //bestFitController.search(context,todobestfit);
                            });
                          },
                        ),
                      ),

                      Container(width: 5.0,),


                    ],
                  ),
                ),


              ],
            ),
          ),

        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // // Update the title of todo object
  // void updateTitle(){
  //   todobestfit.title = titleController.text;
  // }
  //
  // // Update the description of todo object
  // void updateDescription() {
  //   todobestfit.description = descriptionController.text;
  // }

  // Update the title of todo object
  // void updateAuthor(){
  //   todoknowledge.author = autherController.text;
  // }

  //Update the priority
  // void updatePriority(){
  //   todoknowledge.priority=int.parse(prioController.text);
  // }

  // void _delete() async {
  //
  //   moveToLastScreen();
  //
  //   if (todoknowledge.id == null) {
  //     _showAlertDialog('Status', 'No Todo was deleted');
  //     return;
  //   }
  //
  //   int result = await helper.deleteTodoKnowledge(todoknowledge.id);
  //   if (result != 0) {
  //     _showAlertDialog('Status', 'Fair item Deleted Successfully');
  //   } else {
  //     _showAlertDialog('Status', 'Error Occured while Deleting Todo');
  //   }
  // }

  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

}