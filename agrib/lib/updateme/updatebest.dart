import 'dart:async';
import 'package:agrib/updateme/updateme.dart';
import 'package:flutter/material.dart';
import 'package:agrib/common/database_helper.dart';
import 'package:intl/intl.dart';

class UpdateBest extends StatefulWidget {

  final String appBarTitle;
  final UpdateMe todoupdate;

  UpdateBest(this.todoupdate, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return UpdateDetailState(this.todoupdate, this.appBarTitle);
  }

}

class UpdateDetailState extends State<UpdateBest> {

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  UpdateMe todoupdate;
  String dropdownvalue = 'Item 1';

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController prioController = TextEditingController();

  UpdateDetailState(this.todoupdate, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .title;

    titleController.text = todoupdate.title;
    descriptionController.text = todoupdate.description;
    //prioController.text = todoupdate.priority.toString();

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
                //         todoupdate.description=dropdownvalue.toString();
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
                        labelText: 'Title',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Description Text Field');
                      updateDescription();
                    },
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),


                // Padding(
                //   padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                //   child: TextField(
                //     controller: prioController,
                //     style: textStyle,
                //     onChanged: (value) {
                //       debugPrint('Something changed in Priority Text Field');
                //       updatePriority();
                //     },
                //     decoration: InputDecoration(
                //         labelText: 'Rough Cost',
                //         labelStyle: textStyle,
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5.0)
                //         )
                //     ),
                //   ),
                // ),

                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();
                            });
                          },
                        ),
                      ),

                      Container(width: 5.0,),

                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Delete button clicked");
                              _delete();
                            });
                          },
                        ),
                      ),

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
    todoupdate.title = titleController.text;
  }

  // Update the description of todo object
  void updateDescription() {
    todoupdate.description = descriptionController.text;
  }

  //Update the priority
  // void updatePriority(){
  //   todoupdate.priority=int.parse(prioController.text);
  // }

  // Save data to database
  void _save() async {

    moveToLastScreen();

    todoupdate.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (todoupdate.id != null) {  // Case 1: Update operation
      result = await helper.updateTodoUpdate(todoupdate);
    } else { // Case 2: Insert Operation
      result = await helper.insertTodoUpdate(todoupdate);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Fair item Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving Todo');
    }

  }


  void _delete() async {

    moveToLastScreen();

    if (todoupdate.id == null) {
      _showAlertDialog('Status', 'No Todo was deleted');
      return;
    }

    int result = await helper.deleteTodoUpdate(todoupdate.id);
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