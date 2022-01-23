import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'calculation/calculation_page.dart';
import 'shopping_list/shopping_list_page.dart';
import 'todo/main.dart';
import 'total_amount_calculation/total_amount_calculation_page.dart';

const kColorPrimary = Color(0xFFFFDC80);
const kColorText = Color(0xFF182435);
const kColorBackground = Color(0xFFF3F3F3);
const kColorRed = Color(0xFF182435);
const kColorGreen = Color(0xFF56C293);
const kColorGrey = Color(0xFFF8F5EA);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: const [Locale('ja','JP')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      title: '楽する買い物',
      theme:ThemeData(
        primaryColor: const Color(0xFFF3F3F3),
        scaffoldBackgroundColor: const Color(0xFFEAE9E7),
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

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery
        .of(context)
        .padding
        .top;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(145, 131, 222, 1),
          Color.fromRGBO(160, 148, 227, 1),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: kColorPrimary,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: topPadding),
              const SizedBox(height: 10),
              const AnimatedImage(),
              const SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[
                      Expanded(
                        child:Container(
                          margin: const EdgeInsets.only(bottom:10),
                          width: double.infinity,
                          color: kColorPrimary,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton.icon(
                                  label: const Text(
                                    '電卓',
                                    style: TextStyle(
                                        color:kColorText,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.calculate_outlined,
                                    color:kColorText,
                                    size: 30.0,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    elevation: 1,
                                    fixedSize: const Size(200, 50),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const CalculationPage()),
                                    );
                                  },
                                ),
                              ]
                          ),
                        ),
                      ),
                      Expanded(
                        child:Container(
                          margin: const EdgeInsets.only(bottom:5),
                          width: double.infinity,
                          color: kColorPrimary,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton.icon(
                                  label: const Text(
                                    '電卓',
                                    style: TextStyle(
                                        color:kColorText,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.calculate_outlined,
                                    color:kColorText,
                                    size: 30.0,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary:Colors.white,
                                    elevation: 1,
                                    fixedSize: const Size(200, 50),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const CalculationPage()),
                                    );
                                  },
                                ),
                              ]
                          ),
                        ),
                      ),
                    ]

                  ),
                  Row(
                    children: [
                      Expanded(
                        child:Container(
                          margin: const EdgeInsets.only(bottom:5),
                          width: double.infinity,
                          color: kColorPrimary,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton.icon(
                                  label: const Text(
                                    '電卓',
                                    style: TextStyle(
                                        color:kColorText,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.calculate_outlined,
                                    color:kColorText,
                                    size: 30.0,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    elevation: 1,
                                    fixedSize: const Size(200, 50),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const CalculationPage()),
                                    );
                                  },
                                ),
                              ]
                          ),
                        ),
                      ),
                      Expanded(
                        child:Container(
                          margin: const EdgeInsets.only(bottom:5),
                          width: double.infinity,
                          color: kColorPrimary,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton.icon(
                                  label: const Text(
                                    '電卓',
                                    style: TextStyle(
                                        color:kColorText,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.calculate_outlined,
                                    color:kColorText,
                                    size: 30.0,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    elevation: 1,
                                    fixedSize: const Size(200, 50),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const CalculationPage()),
                                    );
                                  },
                                ),
                              ]
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedImage extends StatefulWidget {
  const AnimatedImage({Key? key}) : super(key: key);

  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin{
  late final AnimationController _controller=AnimationController(
    vsync: this,
    duration: const Duration(seconds:2),
  )..repeat(reverse: true);

  late final Animation<Offset> _animation=Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.05,0.05),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/products.png'),
        SlideTransition(
          position: _animation,
          child: Image.asset('assets/images/shopping_person.png'),
        ),
      ],
    );
  }
}

  /*@override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:const Text(
            '楽する買い物',
            style: TextStyle(color:kColorText),
        ),
        backgroundColor:kColorPrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 3,
            child:Container(
              margin: const EdgeInsets.only(bottom:5),
              width: double.infinity,
              color: kColorGrey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton.icon(
                      label: const Text(
                        '電卓',
                        style: TextStyle(
                            color:kColorText,
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      icon: const Icon(
                        Icons.calculate_outlined,
                        color:kColorText,
                        size: 30.0,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: kColorPrimary,
                        elevation: 1,
                        fixedSize: const Size(200, 50),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CalculationPage()),
                        );
                      },
                    ),
                  ]
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(bottom:5),
              width: double.infinity,
              color: kColorGrey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton.icon(
                      label:const Text(
                        '買い物リスト',
                        style: TextStyle(
                            color:kColorText,
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      icon: const Icon(
                        Icons.checklist,
                        color:kColorText,
                        size: 30.0,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: kColorPrimary,
                        elevation: 1,
                        fixedSize: const Size(200, 50),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ShoppingListPage()),
                        );
                      },
                    ),
                  ]
              ),
            ),
          ),
          Expanded(
            flex:3,
            child: Container(
              width: double.infinity,
              color: kColorGrey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton.icon(
                      label: const Text(
                        '合計金額計算',
                        style: TextStyle(
                            color:kColorText,
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      icon: const Icon(
                        Icons.attach_money_outlined,
                        color:kColorText,
                        size: 30.0,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: kColorPrimary,
                        elevation: 1,
                        fixedSize: const Size(200, 50),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TotalAmountCalculation()),
                        );
                      },
                    ),
                  ]
              ),
            ),
          ),
        ],
      ),
    );
  }*/



