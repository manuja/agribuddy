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
  String mainCrop;
  String landScape;
  String soilItem;
  String rainItem;
  int tempItem;


  TextEditingController cropController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  //TextEditingController prioController = TextEditingController();


  TodoDetailState(this.todo, this.appBarTitle);

  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  String selectedCountry;

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
      //todo.maincrop=mainCrop.toString();
      todo.landscape=landScape.toString();
      todo.soil=soilItem.toString();
      todo.rain=rainItem.toString();

    //String _dropdownvalue;
    //String mainCrop;

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

    var itemsTemp = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25,26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99];

    // final _formKey = GlobalKey<FormState>();
    // bool _autovalidate = false;


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

            body: Form(
           // padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            key: _formKey,
            autovalidate: _autovalidate,
            child: ListView(
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0,left: 10.0, right: 15.0),
                  child: DropdownButtonFormField(

                    // Initial Value
                    value: mainCrop,
                    hint: Text(
                      'Main Crop',
                    ),
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    //After selecting the desired option,it will
                    //change button value to selected value
                    onChanged: (String value) {
                      setState(() {
                        mainCrop = value;
                        todo.maincrop=mainCrop.toString();

                      });
                    },
                    validator: (value) => value == null ? 'Main Crop is required' : null,
                    // onChanged: (value) =>
                    //     setState(() => mainCrop = value),
                    // validator: (value) => value == null ? 'field required' : null,
                    // items:
                    // ['MR.', 'MS.'].map<DropdownMenuItem<String>>((String value) {
                    //   return DropdownMenuItem<String>(
                    //     value: value,
                    //     child: Text(value),
                    //   );
                    // }).toList(),
                  ),
                  ),

                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0,left: 10.0, right: 15.0),
                  child: DropdownButtonFormField(

                    // Initial Value
                    value: landScape,
                    hint: Text(
                      'Landscape',
                    ),
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
                    validator: (value) => value == null ? 'Landscape is required' : null,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0,left: 10.0, right: 15.0),
                  child: DropdownButtonFormField(

                    // Initial Value
                    value: soilItem,
                    hint: Text(
                      'Soil Type',
                    ),
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
                    validator: (value) => value == null ? 'Soil Type is required' : null,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0,left: 10.0, right: 15.0),
                  child: DropdownButtonFormField(

                    // Initial Value
                    value: rainItem,
                    hint: Text(
                      'Rain Level',
                    ),
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
                    validator: (value) => value == null ? 'Rain Level is required' : null,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0,left: 10.0, right: 15.0),
                  child: DropdownButtonFormField(

                    // Initial Value
                    value: tempItem,
                    hint: Text(
                      'Temperature',
                    ),
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: itemsTemp.map((int items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items.toString()),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (int value) {
                      setState(() {
                        tempItem = value;
                        todo.title=tempItem;
                        print(tempItem);
                      });
                    },
                    validator: (value) => value == null ? 'Temperature is required' : null,
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 15.0, bottom: 15.0,left: 10.0, right: 15.0),
                //   child: TextField(
                //     controller: titleController,
                //     style: textStyle,
                //     onChanged: (value) {
                //       debugPrint('Something changed in Title Text Field');
                //       updateTitle();
                //     },
                //     decoration: InputDecoration(
                //         labelText: 'Temperature',
                //         labelStyle: textStyle,
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5.0)
                //         )
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(top: 15.0, bottom: 15.0,left: 10.0, right: 15.0),
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
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0,left: 10.0, right: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Search',
                            textScaleFactor: 1.5,
                          ),
                          // onPressed: () {
                          //   setState(() {
                          //    // _save();
                          //     _search();
                          //   });
                          // },
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        //form is valid, proceed further
                        print("done good");
                        _search(); //save once fields are valid, onSaved method invoked for every form fields

                      } else {
                        print("not done");
                        setState(() {
                          _autovalidate = true; //enable realtime validation
                        });
                      }
                    }
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