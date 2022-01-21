import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'calculation/calculation_page.dart';
import 'shopping_list/shopping_list_page.dart';
import 'todo/main.dart';
import 'total_amount_calculation/total_amount_calculation_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      supportedLocales: const [Locale('ja','JP')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      title: '楽する買い物',
      theme:ThemeData(
        primarySwatch:Colors.blue,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
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
        title:const Text('楽する買い物'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('電卓'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalculationPage()),
                );
              },
            ),
            /*ElevatedButton(
              child: const Text('合計金額の計算'),
              onPressed: () {
                //Navigator.of(context).push(TotalAmountCalculation(price: 'ああ', number: 1,text:'ああ')),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TotalAmountCalculation()),
                );
              },
            ),*/
            ElevatedButton(
              child: const Text('買い物リスト'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShoppingListPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('todo'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TodoListApp()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('合計金額計算'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TotalAmountCalculation()),
                );
              },
            ),
          ],
        )

      ),
    );
  }
}


