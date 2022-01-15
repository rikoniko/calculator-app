import 'package:flutter/material.dart';

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
  _TextFiledState createState() => _TextFiledState();
}


class _TextFiledState extends State<TextField> {
  String test='1+1';

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
  final _key;
  Button(this._key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text("$_key"),
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
      ),
      onPressed: () {},
    );
  }
}