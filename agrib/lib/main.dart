import 'package:flutter/material.dart';
import 'common/dashboard.dart';

void main() {
  runApp(AgribApp());
}

class AgribApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

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