import 'package:calculator_app/total_amount_calculation/total_amount_calculation.dart';
import 'package:flutter/material.dart';

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

  final methodItems=['割引','%OFF'];
  String? methodValue;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const SizedBox(height: 20),
              ///商品名
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "商品",
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
                controller: TextEditingController(text: _discountProduct),
                onChanged: (String value) {
                  _discountProduct = value;
                },
              ),
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
                controller: TextEditingController(text: _discountProductNumber),
                onChanged: (String value) {
                  _discountProductNumber = value;
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
    );
  }

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

}
