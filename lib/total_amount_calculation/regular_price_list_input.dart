import 'package:flutter/material.dart';
import 'regular_price_list_store.dart';
import 'total_amount_calculation.dart';

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
      // アプリケーションバーに表示するタイトル
        title: Text(_isCreateRegularPrice ? 'Todo追加' : 'Todo更新'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child:SingleChildScrollView(
          child:Column(
            children:<Widget>[
              const SizedBox(height: 20),
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "値段",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
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
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "詳細",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
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
                      color: Colors.blue,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
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
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //キャンセルボタン
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Todoリスト画面に戻る
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  child: const Text(
                    "キャンセル",
                    style: TextStyle(color: Colors.blue),
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
