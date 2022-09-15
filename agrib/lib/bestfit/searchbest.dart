import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agrib/bestfit/bestfit.dart';
import 'package:agrib/common/database_helper.dart';
import 'package:intl/intl.dart';

import 'bestfitlistsearch.dart';

class SearchBest extends StatefulWidget {

  final String appBarTitle;
  final BestFit todo;

  SearchBest(this.todo, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return TodoDetailState(this.todo, this.appBarTitle);
  }

}

class TodoDetailState extends State<SearchBest> {

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  BestFit todo;
  String mainCrop = 'Food crops';
  String landScape= 'Hill Country/Mountain';
  String soilItem = 'Salty';
  String rainItem = 'High';


  TextEditingController cropController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  //TextEditingController prioController = TextEditingController();


  TodoDetailState(this.todo, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .title;

      titleController.text = todo.title.toString();
      descriptionController.text = todo.description;
      //prioController.text = todo.priority.toString();
      cropController.text=todo.crop;
      todo.maincrop=mainCrop.toString();
      todo.landscape=landScape.toString();
      todo.soil=soilItem.toString();
      todo.rain=rainItem.toString();

    var itemsRain = [
      'High',
      'Low',
      'Medium'
    ];
    var itemsSoil= [
      'Salty',
      'Humas',
      'Clay'
    ];

    var items = [
      'Food crops',
      'Feed crops',
      'Oil crops',
      'Ornamental crops',
      'Industrial crops',
    ];

    var itemsLandScape = [
      'Hill Country/Mountain',
      'Plain Ground',
      'Coast',
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

                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: DropdownButton(

                    // Initial Value
                    value: mainCrop,
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String newValue) {
                      setState(() {
                        mainCrop = newValue;
                        todo.maincrop=mainCrop.toString();

                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: DropdownButton(

                    // Initial Value
                    value: landScape,
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: itemsLandScape.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String newValue) {
                      setState(() {
                        landScape = newValue;
                        todo.landscape=landScape.toString();
                        print(landScape);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: DropdownButton(

                    // Initial Value
                    value: soilItem,
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: itemsSoil.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String newValue) {
                      setState(() {
                        soilItem = newValue;
                         todo.soil=soilItem.toString();
                        print(soilItem);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: DropdownButton(

                    // Initial Value
                    value: rainItem,
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: itemsRain.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String newValue) {
                      setState(() {
                        rainItem = newValue;
                         todo.rain=rainItem.toString();
                        print(rainItem);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: cropController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Title Text Field');
                      updateCrop();
                    },
                    decoration: InputDecoration(
                        labelText: 'Crop',
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
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Title Text Field');
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Temperature',
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
                             // _save();
                              _search();
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
  void updateCrop(){
    todo.crop = cropController.text;
  }

  // Update the title of todo object
  void updateTitle(){
    todo.title = int.parse(titleController.text);
  }

  // Update the description of todo object
  void updateDescription() {
    todo.description = descriptionController.text;
  }

  //Update the priority
  void updatePriority(){
    //todo.priority=int.parse(prioController.text);
  }

  // Save data to database
  void _save() async {

    print("hiiiiiii all");
    print(todo.maincrop);
    print(todo.landscape);
    print(todo.soil);
    print(todo.rain);
    print(todo.crop);
    print(todo.title);
    print(todo.description);
    //moveToLastScreen();

   //todo.date = DateFormat.yMMMd().format(DateTime.now());
    //todo.title=int.parse(todo.title);
    int result;
    if (todo.id != null) {  // Case 1: Update operation
      result = await helper.updateTodo(todo);
    } else { // Case 2: Insert Operation
      result = await helper.insertTodo(todo);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Fair item Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving Todo');
    }

  }

  // Save data to database
  void _search() async {

    print("welcome to search"+todo.title.toString());

    //moveToLastScreen();
    //bool result=false;
    //debugPrint("xddxxy"+knowtodo.id.toString());
    //if (todo.id != null) {
    print("aaaa");
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BestFitListSearch(todo, "aaaaaa");
    }));

    //}else{
    print("aass");
    //}


    // if (result == true) {
    //   updateListView();
    // }

    print("hiiiiiii all");
    print(todo.maincrop);
    print(todo.landscape);
    print(todo.soil);
    print(todo.rain);
    print(todo.crop);
    print(todo.title);
    print(todo.description);
    //moveToLastScreen();

    //todo.date = DateFormat.yMMMd().format(DateTime.now());
    // int result;
    // if (todo.id != null) {  // Case 1: Update operation
    //   result = await helper.updateTodo(todo);
    // } else { // Case 2: Insert Operation
    //   result = await helper.insertTodo(todo);
    // }
    //
    // if (result != 0) {  // Success
    //   _showAlertDialog('Status', 'Fair item Saved Successfully');
    // } else {  // Failure
    //   _showAlertDialog('Status', 'Problem Saving Todo');
    // }

  }


  void _delete() async {

    moveToLastScreen();

    if (todo.id == null) {
      _showAlertDialog('Status', 'No Todo was deleted');
      return;
    }

    int result = await helper.deleteTodo(todo.id);
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