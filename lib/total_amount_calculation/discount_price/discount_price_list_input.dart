import 'dart:convert';

import 'package:calculator_app/total_amount_calculation/total_amount_calculation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'discount_price_list_store.dart';

const kColorPrimary = Color(0xFFFFDC80);
const kColorText = Color(0xFF182435);
const kColorBackground = Color(0xFFF3F3F3);
const kColorRed = Color(0xFF182435);
const kColorGreen = Color(0xFF56C293);
const kColorGrey = Color(0xFFF8F5EA);

class DiscountPriceInputPage extends StatefulWidget {
  final DiscountPriceList? discountPriceList;

  const DiscountPriceInputPage({Key? key, this.discountPriceList}) : super(key: key);

  @override
  _DiscountPriceInputPageState createState() => _DiscountPriceInputPageState();
}

class _DiscountPriceInputPageState extends State<DiscountPriceInputPage> {
  final DiscountPriceListStore _store=DiscountPriceListStore();
  /// 新規追加か
  late bool _isCreateDiscountPrice;

  /// 画面項目：作成日時
  late String _createDate;

  /// 画面項目：更新日時
  late String _updateDate;

  //商品名
  late String _discountProduct;
  //値段
  late String _discountPrice;
  //何％引・何割引
  late String _discountNumber;
  //％引・割引
  late String _discountMethod;
  //個数
  late String _discountProductNumber;
  //メモ
  late String _discountMemo;
  //商品の個数表示用
  late int count;

  final methodItems=['割引','%OFF'];
  String? methodValue;

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
    var discountPriceList = widget.discountPriceList;
    _discountProduct = discountPriceList?.discountProduct ?? "";
    _discountPrice = discountPriceList?.discountPrice ?? "";
    _discountNumber=discountPriceList?.discountNumber ?? "";
    _discountMethod=discountPriceList?.discountMethod ?? "";
    _discountProductNumber=discountPriceList?.discountProductNumber ?? "";
    _discountMemo = discountPriceList?.discountMemo ?? "";
    _createDate = discountPriceList?.createDate ?? "";
    _updateDate = discountPriceList?.updateDate ?? "";
    _isCreateDiscountPrice = discountPriceList == null;
    //オートコンプリートのデータを呼び出す
    fetchAutoCompleteData();
    //商品の個数を初期化する
    InitProductNumber();
  }

  @override
  Widget build(BuildContext context) =>GestureDetector(
    onTap: ()=>FocusScope.of(context).unfocus(),
    child: Scaffold(
      appBar: AppBar(
        title:Text(
          _isCreateDiscountPrice ? '商品追加' : '商品詳細',
          style: const TextStyle(color:kColorText),
        ),
        backgroundColor:kColorPrimary,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child:SingleChildScrollView(
          child:Column(
            children:<Widget>[
              ///商品名
              DiscountProductNameArea(),
              const SizedBox(height: 20),
              ///値段
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
                controller: TextEditingController(text: _discountPrice),
                onChanged: (String value) {
                  _discountPrice = value;
                },
              ),
              ///何％引・割引
              TextField(
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: const InputDecoration(
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
                controller: TextEditingController(text: _discountNumber),
                onChanged: (String value) {
                  _discountNumber = value;
                },
              ),
              ///％OFFor割引
              DropdownButton(
                value: methodValue,
                items: methodItems.map(buildMenuItem).toList(),
                onChanged: (value){
                  setState(() {
                    methodValue=value as String?;
                    _discountMethod=value!;
                  });
                },
              ),
              ///個数
              ProductNumberArea(context, changeValue: (isIncrement){
                if(isIncrement){
                  count++;
                  _discountProductNumber=count.toString();
                  setState(() {});
                }else{
                  count--;
                  _discountProductNumber=count.toString();
                  setState(() {});
                }
              }),
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
                controller: TextEditingController(text: _discountMemo),
                onChanged: (String value) {
                  _discountMemo = value;
                },
              ),
              const SizedBox(height: 20),
              // 追加/更新ボタン
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_isCreateDiscountPrice) {
                      // Todoを追加する
                      _store.add(_discountProduct,_discountPrice,_discountNumber,_discountMethod, _discountProductNumber,_discountMemo);
                    } else {
                      // Todoを更新する
                      _store.update(widget.discountPriceList!,_discountProduct,_discountPrice,_discountNumber,_discountMethod, _discountProductNumber,_discountMemo);
                    }
                    // Todoリスト画面に戻る
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    _isCreateDiscountPrice ? '追加' : '更新',
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

  DropdownMenuItem<String> buildMenuItem(String method)=> DropdownMenuItem(
        value: method,
      child: Text(
        method,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );

  Widget DiscountProductNameArea() {
    return isLoading? const Center(child: CircularProgressIndicator(),):Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Autocomplete(
            optionsBuilder: (TextEditingValue textEditingValue){
              TextEditingController(text: _discountProduct);
              if(textEditingValue.text.isEmpty){
                return const Iterable<String>.empty();
              }else{
                return autoCompleteData.where((word) => word.contains(textEditingValue.text));
              }
            },
            onSelected: (String selectedString){
              _discountProduct=selectedString;
            },
            fieldViewBuilder: (context,textEditingController,focusNode,onEditingComplete){
              return TextField(
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
                focusNode: focusNode,
                onEditingComplete: onEditingComplete,
                controller: textEditingController..text=_discountProduct,
                //controller: TextEditingController(text: _product),
                onChanged: (String value) {
                  _discountProduct = value;
                },
              );
            },
          )
        ],

      ),
    );
  }

  Widget ProductNumberArea(BuildContext context, {double width = 94, double height = 32, required void Function(bool isIncrement) changeValue}) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xffeeeeee),
        ),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    ElevatedButton(
                      child: null,
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        primary: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        changeValue(false);
                      },
                    ),
                    const IgnorePointer(
                      ignoring: true,
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.remove, size: 24, color: Colors.black),
                      ),
                    )
                  ],
                )
            ),
            Text("$count"),
            Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    ElevatedButton(
                      child: null,
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        primary: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        changeValue(true);
                      },
                    ),
                    const IgnorePointer(
                      ignoring: true,
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.add, size: 24, color: Colors.black),
                      ),
                    )
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

  void InitProductNumber() {
    if(_discountProductNumber==""){
      count=0;
    }else{
      count=int.parse(_discountProductNumber);
    }
  }

}
