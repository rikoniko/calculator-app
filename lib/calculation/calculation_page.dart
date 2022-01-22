import 'dart:async';
import 'package:flutter/material.dart';
import 'calculation.dart';

const kColorPrimary = Color(0xFFFFDC80);
const kColorText = Color(0xFF182435);
const kColorBackground = Color(0xFFF3F3F3);
const kColorRed = Color(0xFF182435);
const kColorGreen = Color(0xFF56C293);
const kColorGrey = Color(0xFFF8F5EA);

void main() {
  runApp(const CalculationPage());
}

class CalculationPage extends StatelessWidget {
  const CalculationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          '電卓',
          style: TextStyle(color:kColorText),
        ),
        backgroundColor:kColorPrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TextField(),
          Keybutton(),
        ],
      ),
    );
  }
}

//電卓の表示部分
class TextField extends StatefulWidget {
  const TextField({Key? key}) : super(key: key);

  @override
  _TextFiledState createState() => _TextFiledState();
}

class _TextFiledState extends State<TextField> {
  String expression="";

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

  static final controller = StreamController.broadcast();
  @override
  void initState() {
    controller.stream.listen((event) => UpdateText(event));
    controller.stream.listen((event) => Calculator.GetKey(event));
  }
}

class Keybutton extends StatelessWidget {
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
              color: kColorBackground,
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
    return Container(
        child: ElevatedButton(
          child: Center(
            child: Text(
              num,
              style: const TextStyle(
                  color:kColorText,
                  fontSize: 40,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
          onPressed: (){
            _TextFiledState.controller.sink.add(num);
          },
          style: ElevatedButton.styleFrom(
            primary: kColorPrimary,
            elevation: 1,
          ),
        )
    );

  }
}