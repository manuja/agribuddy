import 'package:flutter/material.dart';

class Footer  extends StatelessWidget {

  String title = "";
  double fontSize = 0;

  Footer({
    this.title,
    Key key,
  }) : super(key: key);
  //Footer(title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: Colors.black26,

      ),
      textAlign: TextAlign.center,
    );
  }
  // String title;
  // Footer (title);
  //
  // @override
  // State<StatefulWidget> createState() {
  //   return _FooterWidgetState();
  // }
}

// class _FooterWidgetState extends State<Footer> {
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: TextStyle(
//         fontSize: 14.0,
//         fontWeight: FontWeight.bold,
//         color: Colors.black26,
//
//       ),
//       textAlign: TextAlign.center,
//     );
//   }
// }