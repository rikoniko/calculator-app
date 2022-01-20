import 'dart:async';

import 'package:flutter/material.dart';
import 'calculation.dart';
import 'calculation_page.dart';
import 'discount_calculation.dart';
import 'total_amount_calculation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: '楽する買い物',
      theme:ThemeData(
        primarySwatch:Colors.blue,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:Text('楽する買い物'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('電卓'),
              onPressed: () {
                // ここにボタンを押した時に呼ばれるコードを書く
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalculationPage()),
                );
              },
            ),
            ElevatedButton(
              child: Text('合計金額の計算'),
              onPressed: () {
                // ここにボタンを押した時に呼ばれるコードを書く
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TotalAmountCalculation()),
                );
              },
            ),

          ],
        )

      ),
    );
  }
}


