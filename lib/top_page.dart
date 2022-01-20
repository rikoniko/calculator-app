import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar:AppBar(title:Text('KBOYのFlutter大学'),),
        backgroundColor:Colors.white,
        body: Center(
          child: RaisedButton(child:Text('Button'),onPressed:(){}),
        ),
      ),
    );
  }
}