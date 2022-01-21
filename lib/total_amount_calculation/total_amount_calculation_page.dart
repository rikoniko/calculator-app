import 'dart:async';

import 'package:calculator_app/total_amount_calculation/regular_price_list_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'regular_price_list_store.dart';
import 'total_amount_calculation.dart';

void main() {
  runApp(const TotalAmountCalculation());
}


class TotalAmountCalculation extends StatefulWidget {
  const TotalAmountCalculation({Key? key}) : super(key: key);

  @override
  _TotalAmountCalculationState createState() => _TotalAmountCalculationState();
}

class _TotalAmountCalculationState extends State<TotalAmountCalculation> {
  int sum=0;
  final RegularPriceListStore _store=RegularPriceListStore();
  void _pushTodoInputPage([RegularPrice? regularPrice]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return RegularPriceInputPage(regularPrice: regularPrice);
        },
      ),
    );
    setState(() {});
  }


  @override
  void initState() {
    super.initState();

    Future(
          () async {
        // ストアからTodoリストデータをロードし、画面を更新する
        setState(() => _store.load());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // アプリケーションバーに表示するタイトル
        title: const Text('合計金額計算'),
      ),
      body: Column(
        children: [
          Row(
              children: const [
                Expanded(child: Text('', style: TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                Expanded(child: Text('値段', style:  TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                Expanded(child: Text('個数', style:  TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                Expanded(child: Text('メモ', style:  TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
              ]
          ),
          Expanded(child:ListView.builder(
            itemCount: _store.count(),
            itemBuilder: (context, index) {
              // インデックスに対応する商品を取得する
              var item = _store.finalByIndex(index);
              //合計金額の計算
              sum+=int.parse(item.price)*int.parse(item.number);
              return Slidable(
                // 右方向にリストアイテムをスライドした場合のアクション
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        // Todo編集画面に遷移する
                        _pushTodoInputPage(item);
                      },
                      backgroundColor: Colors.yellow,
                      icon: Icons.edit,
                      label: '編集',
                    ),
                  ],
                ),
                // 左方向にリストアイテムをスライドした場合のアクション
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        // Todoを削除し、画面を更新する
                        setState(() => {
                          _store.delete(item),
                        });
                      },
                      backgroundColor: Colors.red,
                      icon: Icons.edit,
                      label: '削除',
                    ),
                  ],
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: ListTile(
                    leading: Text(item.id.toString()),
                    title: Row(
                      children: <Widget>[
                        Expanded(child: Text(item.price+"円")),
                        Expanded(child: Text(item.number)),
                        Expanded(child: Text(item.memo)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          ),
          Expanded(child:Align(
            alignment: Alignment.centerRight,
              child:Text(
                '$sum',
                style: const TextStyle(
                  fontSize: 64.0,
                ),
              ),
            ),
          ),
        ],

      ),
      // Todo追加画面に遷移するボタン
      floatingActionButton: FloatingActionButton(
        // Todo追加画面に遷移する
        onPressed: _pushTodoInputPage,
        child: const Icon(Icons.add),
      ),
    );
  }


}

