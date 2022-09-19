import 'package:agrib/helpme/helpme.dart';
import 'package:agrib/knowledgeup/knowledge.dart';
import 'package:agrib/knowledgeup/knowledgeup.dart';
import 'package:flutter/material.dart';
import 'package:agrib/updateme/updatelist.dart';
import 'package:agrib/bestfit/searchbest.dart';
import 'package:agrib/bestfit/bestfitlist.dart';
import 'package:agrib/knowledgeup/knowledgeuplist.dart';

import 'footer.dart';
class MyGridScreen extends StatefulWidget {

  MyGridScreen({Key key}) : super(key: key);

  @override
  _MyGridScreenState createState() => _MyGridScreenState();
}

class _MyGridScreenState extends State<MyGridScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Agri Buddy"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
          child: GridView.extent(
            primary: false,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            maxCrossAxisExtent: 200.0,
            children: <Widget>[
              InkWell(
                onTap: () {Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new BestFitList()));}, // Handle your callback
                child: Container(
                  padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightGreen)
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.arrow_circle_up_outlined,size: 60,color: Colors.lightGreen),
                        SizedBox(height: 8),
                        Center(
                          child: Text(
                            'Best Fit',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              //color: Color(0xFF9EC33B),
                            ),
                          ),
                        ),
                      ],
                    )
                  //color: Colors.yellow,
                ),
              ),
              InkWell(

                onTap: () {Knowledge todoknowledge;
Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new KnowledgeupList()));}, // Handle your callback
                child: Container(
                  padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightGreen)
                    ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.book_outlined,size: 60,color: Colors.lightGreen),
                      SizedBox(height: 8),
                      Center(
                        child: Text(
                          'Knowledge Up',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            //color: Color(0xFF9EC33B),
                          ),
                        ),
                      ),
                    ],
                  )
                  //color: Colors.blue,
                ),
              ),
              InkWell(
                onTap: () {Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new UpdateList()));}, // Handle your callback
                child: Container(
                  padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightGreen)
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.info_outline,size: 60,color: Colors.lightGreen),
                        SizedBox(height: 8),
                        Center(
                          child: Text(
                            'Update Me',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              //color: Color(0xFF9EC33B),
                            ),
                          ),
                        ),
                      ],
                    )
                  //color: Colors.blue,

                ),
              ),
              InkWell(
                onTap: () {Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new HelpMeScreen()));}, // Handle your callback
                child: Container(
                  padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightGreen)
                    ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.live_help_outlined,size: 60,color: Colors.lightGreen),
                      SizedBox(height: 8),
                      Center(
                        child: Text(
                          'Help Me',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            //color: Color(0xFF9EC33B),
                          ),
                        ),
                      ),
                    ],
                  )
                 // color: Colors.yellow,
                ),
              ),

            ],
          )),
      bottomNavigationBar: new BottomAppBar(

        // child: Text(
        //   'Agricultural App - @Ujitha Sudasingha -2022',
        //   style: TextStyle(
        //     fontSize: 14.0,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.black26,
        //
        //   ),
        //   textAlign: TextAlign.center,
        // ),
        child: Footer(title:"Agricultural App - @Ujitha Sudasingha -2022"),
      ),
    );
  }
}