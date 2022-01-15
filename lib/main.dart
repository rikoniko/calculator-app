import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'楽する電卓',
      theme:ThemeData(
        primarySwatch:Colors.blue,
      ),
      home:MainPage(),
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
  TextFiledState createState() => TextFiledState();
}


class TextFiledState extends State<TextField> {
  String test='1+1';

  //表示部分の非同期処理
  void UpdateText(String letter){
    setState(() {
      if(letter=="="||letter=="C")
        test="";
      else
        test+=letter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child:Align(
        alignment: Alignment.centerRight,
        child:Text(
          test,
          style: TextStyle(
            fontSize: 64.0,
          ),
        ),
      ),
    );
  }

  static final controller = StreamController<String>();
  @override
  void initState() {
    controller.stream.listen((event) => UpdateText(event));
  }
}

//キーボタン
class Keyboard extends StatelessWidget {
  var list=[
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
                children: list.map((_key) {
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
  final _key;
  Button(this._key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
          "$_key",
        style: TextStyle(
          color:Colors.amber,
          fontSize:20,
        ),
      ),
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
      ),
      onPressed: () {
        TextFiledState.controller.sink.add(_key);
      },
    );
  }
}
/*class Button extends StatelessWidget {
  final _key;
  Button(this._key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FlatButton(
          child: Center(
            child: Text(
                _key,
                style: TextStyle(
                  fontSize: 46.0,
                  color: Colors.black54,
                )
            ),
          ),
          onPressed: (){
            TextFiledState.controller.sink.add(_key);
          },
        )
    );
  }
}*/

