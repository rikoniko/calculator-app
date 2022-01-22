import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const kColorPrimary = Color(0xFFFFDC80);
const kColorText = Color(0xFF182435);
const kColorBackground = Color(0xFFF3F3F3);
const kColorRed = Color(0xFF182435);
const kColorGreen = Color(0xFF56C293);
const kColorGrey = Color(0xFFF8F5EA);

class ShoppingListAddPage extends StatefulWidget {
  const ShoppingListAddPage({Key? key}) : super(key: key);

  @override
  _ShoppingListAddPageState createState() => _ShoppingListAddPageState();
}

class _ShoppingListAddPageState extends State<ShoppingListAddPage> {
  String _text='';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale("en"),
        Locale("ja"),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      locale: const Locale('ja', 'JP'),
      home:Scaffold(
        appBar: AppBar(
          title:const Text(
            '商品追加',
            style: TextStyle(color:kColorText),
          ),
          backgroundColor:kColorPrimary,
        ),
        body: Container(
          padding: const EdgeInsets.all(64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (String value){
                  setState(() {
                    _text=value;
                  });
                },
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(_text);
                  },
                  child: const Text(
                      'リスト追加',
                      style: TextStyle(color: kColorText),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kColorPrimary,
                    elevation: 1,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'キャンセル',
                    style: TextStyle(color: kColorText),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
