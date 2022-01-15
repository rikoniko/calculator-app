import 'package:flutter/material.dart';
import 'dart:async';
import 'calculation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'楽する電卓',
      theme:ThemeData(
        primarySwatch:Colors.blue,
      ),
      home:const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget{
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
              TextField(),
              Keyboard(),
          ],
        )
    );
  }
}

//表示部分
class TextField extends StatefulWidget {
  const TextField({Key? key}) : super(key: key);

  TextFiledState createState() => TextFiledState();
}


class TextFiledState extends State<TextField> {
  String expression="";

  //表示部分の非同期処理
  void UpdateText(String letter){
    setState(() {
      if(letter=="C") {
        expression = "";
      }
      else if(letter=="="){
        expression="";
        var ans = Calculator.Execute();
        controller.sink.add(ans);
      }
      else if(letter=="e") {
        expression ="Error";
      }
      else {
        expression += letter;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child:Align(
        alignment: Alignment.centerRight,
        child:Text(
          expression,
          style: TextStyle(
            fontSize: 64.0,
          ),
        ),
      ),
    );
  }

  static final controller = StreamController<String>.broadcast();
  @override
  void initState() {
    controller.stream.listen((event) => UpdateText(event));
    controller.stream.listen((event) => Calculator.GetKey(event));
  }
}

//キーボタン
class Keyboard extends StatelessWidget {
  final list=[
    '7', '8', '9', '÷',
    '4', '5', '6', '×',
    '1', '2', '3', '-',
    'C', '0', '=', '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Center(
            child: Container(
              color: const Color(0xff87cefa),
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 3.0,
                crossAxisSpacing: 3.0,
                children: list.map((key) {
                  return GridTile(
                    child: Button(key),
                  );
                }).toList(),
              ),
            )
        )
    );
  }
}

//キーボタンの文字
class Button extends StatelessWidget {
  final num;
  Button(this.num);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
          "$num",
        style: TextStyle(
          color:Colors.amber,
          fontSize:40,
        ),
      ),
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
      ),
      onPressed: () {
        TextFiledState.controller.sink.add(num);
      },
    );
  }
}

