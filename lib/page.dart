import 'package:flutter/material.dart';

class Page extends StatelessWidget {

  final String title;

  Page(this.title);
  String noAvailable = "No rooms available nearby...";
 @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(title), backgroundColor: Colors.redAccent,),
      body: new Center(
        child: new Text(noAvailable),
      ),
    );
  }
}