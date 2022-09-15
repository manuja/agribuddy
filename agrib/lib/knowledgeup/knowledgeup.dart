import 'dart:async';
import 'package:agrib/knowledgeup/knowledge.dart';
import 'package:agrib/knowledgeup/knowledgeuplistsearch.dart';
import 'package:flutter/material.dart';
import 'package:agrib/bestfit/bestfit.dart';
import 'package:agrib/common/database_helper.dart';
import 'package:intl/intl.dart';

import 'knowledgeuplist.dart';

class KnowledgeUp extends StatefulWidget {

  final String appBarTitle;
  final Knowledge todoknowledge;

  KnowledgeUp(this.todoknowledge, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return KnowledgeUpDetailState(this.todoknowledge, this.appBarTitle);
  }

}

class KnowledgeUpDetailState extends State<KnowledgeUp> {

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Knowledge todoknowledge;
  String dropdownvalue = 'Item 1';

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController autherController = TextEditingController();

  KnowledgeUpDetailState(this.todoknowledge, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .title;

    titleController.text = todoknowledge.title;
    descriptionController.text = todoknowledge.description;
    autherController.text = todoknowledge.author;

    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];



    return WillPopScope(

        onWillPop: () {
          moveToLastScreen();
        },

        child: Scaffold(
          appBar: AppBar(
            //title: Text(appBarTitle),
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
                // Padding(
                //   padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                //   child: TextField(
                //     controller: titleController,
                //     style: textStyle,
                //     onChanged: (value) {
                //       debugPrint('Something changed in Title Text Field');
                //       updateTitle();
                //     },
                //     decoration: InputDecoration(
                //         labelText: 'Title',
                //         labelStyle: textStyle,
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5.0)
                //         )
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                //   child: TextField(
                //     controller: descriptionController,
                //     style: textStyle,
                //     onChanged: (value) {
                //       debugPrint('Something changed in Description Text Field');
                //       updateDescription();
                //     },
                //     decoration: InputDecoration(
                //         labelText: 'Description',
                //         labelStyle: textStyle,
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5.0)
                //         )
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                //   child: TextField(
                //     controller: autherController,
                //     style: textStyle,
                //     onChanged: (value) {
                //       debugPrint('Something changed in Description Text Field');
                //       updateAuthor();
                //     },
                //     decoration: InputDecoration(
                //         labelText: 'Author',
                //         labelStyle: textStyle,
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5.0)
                //         )
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                //   child: DropdownButton(
                //
                //     // Initial Value
                //     value: dropdownvalue,
                //     // Down Arrow Icon
                //     icon: const Icon(Icons.keyboard_arrow_down),
                //
                //     // Array list of items
                //     items: items.map((String items) {
                //       return DropdownMenuItem(
                //         value: items,
                //         child: Text(items),
                //       );
                //     }).toList(),
                //     // After selecting the desired option,it will
                //     // change button value to selected value
                //     onChanged: (String newValue) {
                //       setState(() {
                //         dropdownvalue = newValue;
                //         todoknowledge.description=dropdownvalue.toString();
                //         print(dropdownvalue);
                //       });
                //     },
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Title Text Field');
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Search',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
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
                            'Search',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                             // _save();
                             _search();
                            });
                          },
                        ),
                      ),

                      Container(width: 5.0,),

                      // Expanded(
                      //   child: RaisedButton(
                      //     color: Theme.of(context).primaryColorDark,
                      //     textColor: Theme.of(context).primaryColorLight,
                      //     child: Text(
                      //       'Delete',
                      //       textScaleFactor: 1.5,
                      //     ),
                      //     onPressed: () {
                      //       setState(() {
                      //         debugPrint("Delete button clicked");
                      //         _delete();
                      //       });
                      //     },
                      //   ),
                      // ),

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

  // Save data to database
  void _save() async {

    moveToLastScreen();

    todoknowledge.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (todoknowledge.id != null) {  // Case 1: Update operation
      result = await helper.updateTodoKnowledge(todoknowledge);
    } else { // Case 2: Insert Operation
      result = await helper.insertTodoKnowledge(todoknowledge);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Fair item Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving Todo');
    }

  }

  void _search() async {

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