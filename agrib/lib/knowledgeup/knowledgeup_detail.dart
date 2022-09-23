import 'dart:async';
import 'package:agrib/knowledgeup/knowledge.dart';
import 'package:agrib/knowledgeup/knowledgeuplistsearch.dart';
import 'package:flutter/material.dart';
import 'package:agrib/bestfit/bestfit.dart';
import 'package:agrib/common/database_helper.dart';
import 'package:intl/intl.dart';

import 'knowledgeup_controller.dart';
import 'knowledgeuplist.dart';

class KnowledgeUpDetail extends StatefulWidget {

  final String appBarTitle;
  final Knowledge todoknowledge;

  KnowledgeUpDetail(this.todoknowledge, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return KnowledgeUpDetailDescriptionState(this.todoknowledge, this.appBarTitle);
  }

}

class KnowledgeUpDetailDescriptionState extends State<KnowledgeUpDetail> {

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Knowledge todoknowledge;
  String dropdownvalue = 'Item 1';

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController autherController = TextEditingController();
  KnowledgUpController knowledgeupController=new KnowledgUpController();

  KnowledgeUpDetailDescriptionState(this.todoknowledge, this.appBarTitle);

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
                    todoknowledge.title + " by " + todoknowledge.author,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                    ),
                  )
                ),
                Padding(
                    padding: EdgeInsets.only(top: 0.0, bottom: 25.0),
                    child: Text(
                      todoknowledge.date,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text(
                      todoknowledge.description,
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
                              knowledgeupController.search(todoknowledge,context);
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

  // Update the title of todo object
  void updateTitle(){
    todoknowledge.title = titleController.text;
  }

  // Update the description of todo object
  void updateDescription() {
    todoknowledge.description = descriptionController.text;
  }

  // Update the title of todo object
  void updateAuthor(){
    todoknowledge.author = autherController.text;
  }

  //Update the priority
  // void updatePriority(){
  //   todoknowledge.priority=int.parse(prioController.text);
  // }

  void _delete() async {

    moveToLastScreen();

    if (todoknowledge.id == null) {
      _showAlertDialog('Status', 'No Todo was deleted');
      return;
    }

    int result = await helper.deleteTodoKnowledge(todoknowledge.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Fair item Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Todo');
    }
  }

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