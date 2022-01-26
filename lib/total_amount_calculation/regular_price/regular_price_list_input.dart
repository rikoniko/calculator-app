import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'regular_price_list_store.dart';
import '../total_amount_calculation.dart';

const kColorPrimary = Color(0xFFFFDC80);
const kColorText = Color(0xFF182435);
const kColorBackground = Color(0xFFF3F3F3);
const kColorRed = Color(0xFF182435);
const kColorGreen = Color(0xFF56C293);
const kColorGrey = Color(0xFFF8F5EA);

class RegularPriceInputPage extends StatefulWidget {
  final RegularPrice? regularPrice;

  const RegularPriceInputPage({Key? key, this.regularPrice}) : super(key: key);

  @override
  _RegularPriceInputPageState createState() => _RegularPriceInputPageState();
}

class _RegularPriceInputPageState extends State<RegularPriceInputPage> {
  final RegularPriceListStore _store=RegularPriceListStore();
  /// 新規追加か
  late bool _isCreateRegularPrice;

  /// 画面項目：作成日時
  late String _createDate;

  /// 画面項目：更新日時
  late String _updateDate;
  //商品名
  late String _product;
  //値段
  late String _price;
  //個数
  late String _number;
  //メモ
  late String _memo;

  /// オートコンプリート機能
  bool isLoading=false;
  late List<String> autoCompleteData;

  Future fetchAutoCompleteData() async{
    // jsonファイルが読み込まれているかを確認する
    setState(() {
      isLoading=true;
    });
    // jsonファイルを読むこむ
    final String stringData =await rootBundle.loadString("assets/data/product.json");
    // jsonデータをデコードしてDartで扱える型に変換する
    final List<dynamic> json=jsonDecode(stringData);
    final List<String> jsonStringData=json.cast<String>();

    setState(() {
      isLoading=false;
      autoCompleteData=jsonStringData;
    });
  }

  @override
  void initState() {
    super.initState();
    var regularPrice = widget.regularPrice;
    _product=regularPrice?.product ?? "";
    _price = regularPrice?.price ?? "";
    _number=regularPrice?.number ?? "";
    _memo = regularPrice?.memo ?? "";
    _createDate = regularPrice?.createDate ?? "";
    _updateDate = regularPrice?.updateDate ?? "";
    _isCreateRegularPrice = regularPrice == null;
    //オートコンプリートのデータを呼び出す
    fetchAutoCompleteData();
  }

  @override
  Widget build(BuildContext context) =>GestureDetector(
    onTap: ()=>FocusScope.of(context).unfocus(),
    child: Scaffold(
      appBar: AppBar(
        title:Text(
          _isCreateRegularPrice ? '商品追加' : '商品詳細',
          style: const TextStyle(color:kColorText),
        ),
        backgroundColor:kColorPrimary,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child:SingleChildScrollView(
          child:Column(
            children:<Widget>[
              ProductNameArea(),
              const SizedBox(height: 20),
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "商品名",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kColorText,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kColorText,
                    ),
                  ),
                ),
                // TextEditingControllerを使用することで、いちいちsetStateしなくても画面を更新してくれる
                controller: TextEditingController(text: _product),
                onChanged: (String value) {
                  _product = value;
                },
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "値段",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kColorText,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kColorText,
                    ),
                  ),
                ),
                // TextEditingControllerを使用することで、いちいちsetStateしなくても画面を更新してくれる
                controller: TextEditingController(text: _price),
                onChanged: (String value) {
                  _price = value;
                },
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "個数",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kColorText,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kColorText,
                    ),
                  ),
                ),
                // TextEditingControllerを使用することで、いちいちsetStateしなくても画面を更新してくれる
                controller: TextEditingController(text: _number),
                onChanged: (String value) {
                  _number = value;
                },
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 3,
                decoration: const InputDecoration(
                  labelText: "メモ",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kColorText,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kColorText,
                    ),
                  ),
                ),
                // TextEditingControllerを使用することで、いちいちsetStateしなくても画面を更新してくれる
                controller: TextEditingController(text: _memo),
                onChanged: (String value) {
                  _memo = value;
                },
              ),
              const SizedBox(height: 20),
              // 追加/更新ボタン
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_isCreateRegularPrice) {
                      // Todoを追加する
                      _store.add(_product,_price, _number,_memo);
                    } else {
                      // Todoを更新する
                      _store.update(widget.regularPrice!,_product,_price, _number,_memo);
                    }
                    // Todoリスト画面に戻る
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    _isCreateRegularPrice ? '追加' : '更新',
                    style: const TextStyle(color: kColorText),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kColorPrimary,
                    elevation: 1,
                    fixedSize: const Size(200, 50),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //キャンセルボタン
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // Todoリスト画面に戻る
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "キャンセル",
                    style: TextStyle(color: kColorText),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget ProductNameArea() {
    return isLoading? Center(child: CircularProgressIndicator(),):Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Autocomplete(
              optionsBuilder: (TextEditingValue textEditingValue){
                if(textEditingValue.text.isEmpty){
                  return const Iterable<String>.empty();
                }else{
                  return autoCompleteData.where((word) => word.contains(textEditingValue.text));
                }
          })
        ],

      ),
    );
  }

}
