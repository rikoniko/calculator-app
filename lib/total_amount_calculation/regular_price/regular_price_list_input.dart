import 'package:flutter/material.dart';
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

  //値段
  late String _price;
  //個数
  late String _number;
  //メモ
  late String _memo;

  @override
  void initState() {
    super.initState();
    var regularPrice = widget.regularPrice;

    _price = regularPrice?.price ?? "";
    _number=regularPrice?.number ?? "";
    _memo = regularPrice?.memo ?? "";
    _createDate = regularPrice?.createDate ?? "";
    _updateDate = regularPrice?.updateDate ?? "";
    _isCreateRegularPrice = regularPrice == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      _store.add(_price, _number,_memo);
                    } else {
                      // Todoを更新する
                      _store.update(widget.regularPrice!,_price, _number,_memo);
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
    );
  }
}
