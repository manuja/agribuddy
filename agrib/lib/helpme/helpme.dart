import 'package:agrib/common/footer.dart';
import 'package:flutter/material.dart';

class HelpMeScreen extends StatefulWidget {
  HelpMeScreen({Key key}) : super(key: key);

  @override
  _HelpMeScreenScreenState createState() => _HelpMeScreenScreenState();
}

class _HelpMeScreenScreenState extends State<HelpMeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Me"),
        backgroundColor: Colors.lightGreen,
      ),
      body:
      Column(

        children: <Widget>[
          SizedBox(height: 20),
          Container(
            child: Text('Central Hub For Essential Contacts For Agriculture', textAlign: TextAlign.center),

          ),
          Expanded(
            child: Center(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (0.7),
                primary: false,
                padding: const EdgeInsets.all(16),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                //maxCrossAxisExtent: 200.0,
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightGreen)
                      ),
                      child: Column(

                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.account_circle_outlined,size: 60,color: Colors.lightGreen),
                          SizedBox(height: 8),
                          Center(
                            child: Text(
                              'World Organization',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                //color: Color(0xFF9EC33B),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.body1,
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                      child: Icon(Icons.phone_callback_outlined),
                                    ),
                                  ),
                                  TextSpan(text: '   +66769194781 \n', style: TextStyle(
                                    fontSize: 14.0,
                                  ), ),
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                      child: Icon(Icons.email_outlined),
                                    ),
                                  ),
                                  TextSpan(text: '   agri@gmail.com\n', style: TextStyle(
                                    fontSize: 14.0,
                                  ),),
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                      child: Icon(Icons.add_location_alt_outlined),
                                    ),
                                  ),
                                  TextSpan(text: '   2EA,Cross Lane, Canada.', style: TextStyle(
                                    fontSize: 14.0,
                                  ),),
                                ],
                              ),
                            )
                          ),

                        ],
                      )
                    //color: Colors.yellow,
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightGreen)
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.how_to_reg_outlined,size: 60,color: Colors.lightGreen),
                          SizedBox(height: 8),
                          Center(
                            child: Text(
                              'Agri Fundation',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                //color: Color(0xFF9EC33B),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.body1,
                                  children: [
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Icon(Icons.phone_callback_outlined),
                                      ),
                                    ),
                                    TextSpan(text: '   +8890287651 \n', style: TextStyle(
                                      fontSize: 14.0,
                                    ), ),
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Icon(Icons.email_outlined),
                                      ),
                                    ),
                                    TextSpan(text: '   agf@gmail.com\n', style: TextStyle(
                                      fontSize: 14.0,
                                    ),),
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Icon(Icons.add_location_alt_outlined),
                                      ),
                                    ),
                                    TextSpan(text: '   234K, Nisiyama, Japan.', style: TextStyle(
                                      fontSize: 14.0,
                                    ),),
                                  ],
                                ),
                              )
                          ),
                        ],
                      )
                    //color: Colors.blue,
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightGreen)
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.account_box_outlined,size: 60,color: Colors.lightGreen),
                          SizedBox(height: 8),
                          Center(
                            child: Text(
                              'Agriculture Ministry',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                //color: Color(0xFF9EC33B),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.body1,
                                  children: [
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Icon(Icons.phone_callback_outlined),
                                      ),
                                    ),
                                    TextSpan(text: '   +112532412 \n', style: TextStyle(
                                      fontSize: 14.0,
                                    ), ),
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Icon(Icons.email_outlined),
                                      ),
                                    ),
                                    TextSpan(text: '   agsl@gmail.com\n', style: TextStyle(
                                      fontSize: 14.0,
                                    ),),
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Icon(Icons.add_location_alt_outlined),
                                      ),
                                    ),
                                    TextSpan(text: '   80/5, Baththaramulla.', style: TextStyle(
                                      fontSize: 14.0,
                                    ),),
                                  ],
                                ),
                              )
                          ),
                        ],
                      )
                    //color: Colors.blue,

                  ),
                  // Handle your callback
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightGreen)
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.account_balance_outlined,size: 60,color: Colors.lightGreen),
                          SizedBox(height: 8),
                          Center(
                            child: Text(
                              'Agri Department',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                //color: Color(0xFF9EC33B),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.body1,
                                  children: [
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Icon(Icons.phone_callback_outlined),
                                      ),
                                    ),
                                    TextSpan(text: '   +94 812 388331 \n', style: TextStyle(
                                      fontSize: 14.0,
                                    ), ),
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Icon(Icons.email_outlined),
                                      ),
                                    ),
                                    TextSpan(text: '   pagri@gmail.com\n', style: TextStyle(
                                      fontSize: 14.0,
                                    ),),
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Icon(Icons.add_location_alt_outlined),
                                      ),
                                    ),
                                    TextSpan(text: '   P.O.Box. 01, Peradeniya.', style: TextStyle(
                                      fontSize: 14.0,
                                    ),),
                                  ],
                                ),
                              )
                          ),
                        ],
                      )
                    // color: Colors.yellow,
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
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
        child: Footer(title:"Web : https://www.wfo-oma.org"),
      ),
    );
  }
}