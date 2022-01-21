import 'package:calculator_app/total_amount_calculation/total_amount_calculation_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'products.dart';

class RegularPriceListAddPage extends StatefulWidget {
  const RegularPriceListAddPage({Key? key}) : super(key: key);

  @override
  _RegularPriceListAddPageState createState() => _RegularPriceListAddPageState();
}

class _RegularPriceListAddPageState extends State<RegularPriceListAddPage> {
  String price='';
  String number='';
  String text='';
  //late List<Product> products;

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
          padding: const EdgeInsets.all(50),
          child:SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: '値段',
                    ),
                    onChanged: (String tmp_price){
                      setState(() {
                        price=tmp_price;
                      });
                    },
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: '個数',
                    ),
                    onChanged: (String tmp_number){
                      setState(() {
                        number=tmp_number;
                      });
                    },
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'メモ',
                    ),
                    onChanged: (String tmp_text){
                      setState(() {
                        text=tmp_text;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context)=>TotalAmountCalculation(
                              price: price,
                              number: number,
                              text:text,
                            ),
                        ),
                      );
                      //Navigator.of(context).pop(text);
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
      ),
    );
  }
}
