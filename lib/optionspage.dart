import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class OptionsPage extends StatelessWidget {

  final String title;

  OptionsPage(this.title);


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text(title), backgroundColor: Colors.redAccent,),
        body: new ListView( children: <Widget>[

        CheckboxListTile(
          title: const Text('3D Printing'),
          value: false,
          onChanged: (bool newValue) {
          },
        ),

        CheckboxListTile(
          title: const Text('Automotive'),
          value: false,
          onChanged: (bool newValue) {
          },
        ),

        CheckboxListTile(
          title: const Text('Art'),
          value: false,
          onChanged: (bool newValue) {
          },
        ),


    CheckboxListTile(
    title: const Text('CNC Machining'),
    value: false,
    onChanged: (bool newValue) {
    },
    ),

    CheckboxListTile(
    title: const Text('Cooking'),
    value: false,
    onChanged: (bool newValue) {
    },
    ),

        CheckboxListTile(
          title: const Text('Electronics'),
          value: false,
          onChanged: (bool newValue) {
          },
        ),

        CheckboxListTile(
          title: const Text('Pottery'),
          value: false,
          onChanged: (bool newValue) {
          },
        ),

        CheckboxListTile(
    title: const Text('Sewing'),
    value: false,
    onChanged: (bool newValue) {
    },
    ),

  ])

    );
  }
}


 /* @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(title), backgroundColor: Colors.redAccent,),
      body: new Center(
        child: new Text(title),
      ),
    );
  }
}*/