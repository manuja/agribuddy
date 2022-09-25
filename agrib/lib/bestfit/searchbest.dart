import 'dart:async';
import 'dart:io';
import 'package:agrib/bestfit/bestfit_controller.dart';
import 'package:agrib/services/updateme_api_service.dart';
import 'package:flutter/material.dart';
import 'package:agrib/bestfit/bestfit.dart';
import 'package:agrib/common/database_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
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
  NetworkHelper networkHelper = NetworkHelper();
  BestFitController bestFitController=new BestFitController();

  String appBarTitle;
  BestFit todo;
  String mainCrop;
  String landScape;
  String soilItem;
  String rainItem;
  int tempItem;
  String temp="";


  TextEditingController cropController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TodoDetailState(this.todo, this.appBarTitle);



  @override
  void initState() {
    super.initState();
    print("one here");
    getCurrentLocation();

  }


  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  String selectedCountry;
  Position _currentPosition;


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

    return WillPopScope(

        onWillPop: () {
          bestFitController.moveToLastScreen(context);
        },

        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(icon: Icon(
                Icons.arrow_back),
                onPressed: () {
                  bestFitController.moveToLastScreen(context);
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
                   // value: getTemperature(),
                    hint: Text(
                      'Temperature In Celsius',
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
                Padding(
                  padding: EdgeInsets.only(top: 0.0, bottom: 15.0,left: 10.0, right: 15.0),
                   child: Text( "Hint :Current Temperature Of Your Location is " +temp+ "C"

                ),
             ),

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
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        //form is valid, proceed further
                        print("done good");
                        bestFitController.search(context,todo); //save once fields are valid, onSaved method invoked for every form fields

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

                    ],
                  ),
                ),


              ],
            ),
          ),

        ));



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
  // void _save() async {
  //
  //  //todo.date = DateFormat.yMMMd().format(DateTime.now());
  //   //todo.title=int.parse(todo.title);
  //   int result;
  //   if (todo.id != null) {  // Case 1: Update operation
  //     result = await helper.updateTodo(todo);
  //   } else { // Case 2: Insert Operation
  //     result = await helper.insertTodo(todo);
  //   }
  //
  //   if (result != 0) {  // Success
  //     _showAlertDialog('Status', 'Fair item Saved Successfully');
  //   } else {  // Failure
  //     _showAlertDialog('Status', 'Problem Saving Todo');
  //   }
  //
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

  void getCurrentLocation() async {
    print("here also");
    await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
        .then((Position position) {
      print("back here"+position.toString());
      getTemperature(position);

    }).catchError((e) {
      print("is error"+e.toString());
    });
  }

  Future<int> getTemperature(currentLocation) async{

    if(currentLocation==null){
    print("location null");
    }else{
      print("not null");
      var internetconnection = await bestFitController.isConnected();
      if(internetconnection==true) {
        print("I connection is there");
        var lati=currentLocation.latitude.toString();
        var lani=currentLocation.longitude.toString();
        //DatabaseHelper helper = new DatabaseHelper();
        var decodedTemp = await networkHelper.getTemperature(lati,lani);
        print(temp);
        setState(() {
          //String temp;
          temp = temp+decodedTemp[0]['temp'].toString();
        });
        print("abc"+decodedTemp[0]['temp'].toString());
      }
      return int.parse(currentLocation.latitude.round().toString());
    }

  }


}