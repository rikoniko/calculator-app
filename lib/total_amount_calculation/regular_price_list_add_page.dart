import 'package:calculator_app/total_amount_calculation/total_amount_calculation_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class RegularPriceListAddPage extends StatefulWidget {
  const RegularPriceListAddPage({Key? key}) : super(key: key);

  @override
  _RegularPriceListAddPageState createState() => _RegularPriceListAddPageState();
}

class _RegularPriceListAddPageState extends State<RegularPriceListAddPage> {
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
          title: const Text('商品追加'),
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
                    /*Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>TotalAmountCalculation(
                            _text:_text,
                          ),
                      ),
                    );*/
                    Navigator.of(context).pop(_text);
                  },
                  child: const Text('リスト追加', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('キャンセル'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
