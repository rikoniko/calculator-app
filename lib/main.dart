import 'package:calculator_app/total_amount_calculation/discount_price/discount_price_list_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'button_area_widget.dart';
import 'total_amount_calculation/regular_price/regular_price_list_store.dart';

const kColorPrimary = Color(0xFFFFDC80);
const kColorText = Color(0xFF182435);
const kColorBackground = Color(0xFFFFF9EA);
const kColorRed = Color(0xFFE36470);
const kColorGreen = Color(0xFF309398);
const kColorGrey = Color(0xFFF8F5EA);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: [Locale('ja','JP')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      title: '楽する買い物',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final RegularPriceListStore _store=RegularPriceListStore();
  final DiscountPriceListStore _discountStore=DiscountPriceListStore();

  @override
  void initState() {
    super.initState();
    _store.load();
    _discountStore.load();
    setState(() {});
  }

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
              const SizedBox(height: 25),
              const ButtonAria(),
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

