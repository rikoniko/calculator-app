import 'dart:async';
import 'package:calculator_app/total_amount_calculation/discount_price/discount_price_list_input.dart';
import 'package:calculator_app/total_amount_calculation/regular_price/regular_price_list_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'discount_price/discount_price_list_store.dart';
import 'regular_price/regular_price_list_store.dart';
import 'total_amount_calculation.dart';

const kColorPrimary = Color(0xFFFFDC80);
const kColorText = Color(0xFF182435);
const kColorBackground = Color(0xFFF3F3F3);
const kColorRed = Color(0xFFE86D6C);
const kColorGreen = Color(0xFF56C293);
const kColorGrey = Color(0xFFF8F5EA);

void main() {
  runApp(const TotalAmountCalculation());
}


class TotalAmountCalculation extends StatefulWidget {
  const TotalAmountCalculation({Key? key}) : super(key: key);

  @override
  _TotalAmountCalculationState createState() => _TotalAmountCalculationState();
}

class _TotalAmountCalculationState extends State<TotalAmountCalculation> {
  //合計金額
  int sum=0;

  final RegularPriceListStore _store=RegularPriceListStore();
  final DiscountPriceListStore _discountStore=DiscountPriceListStore();

  @override
  void initState() {
    super.initState();
    Future(() async {
        // データをロードしてからsetStateで更新
        _store.load();
        _discountStore.load();
        AddPrice();
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          '合計金額計算',
          style: TextStyle(color:kColorText),
        ),
        backgroundColor:kColorPrimary,
      ),
      body: Column(
        children: [
          Row(
              children: const [
                //Expanded(child: Text('', style: TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
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
              return Slidable(
                // 右方向にリストアイテムをスライドした場合のアクション
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        // Todo編集画面に遷移する
                        _pushRegularPriceInputPage(item);
                      },
                      backgroundColor: kColorGreen,
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
                          AddPrice(),
                        });
                      },
                      backgroundColor: kColorRed,
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
                    title: Row(
                      children: <Widget>[
                        Expanded(child: Text(item.price+" 円")),
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
          ///割引商品テーブル
          const SizedBox(height: 10),
          Row(
              children: const [
                Expanded(child: Text('商品名', style: TextStyle(height: 3.0, fontSize: 10, fontWeight: FontWeight.bold,))),
                Expanded(child: Text('値段', style:  TextStyle(height: 3.0, fontSize: 10, fontWeight: FontWeight.bold,))),
                Expanded(child: Text('割引or％OFF', style: TextStyle(height: 3.0, fontSize: 10, fontWeight: FontWeight.bold,))),
                Expanded(child: Text('個数', style:  TextStyle(height: 3.0, fontSize: 10, fontWeight: FontWeight.bold,))),
                //Expanded(child: Text('メモ', style:  TextStyle(height: 3.0, fontSize: 10, fontWeight: FontWeight.bold,))),
              ]
          ),
          Expanded(child:ListView.builder(
            itemCount: _discountStore.count(),
            itemBuilder: (context, index) {
              // インデックスに対応する商品を取得する
              var item = _discountStore.finalByIndex(index);
              return Slidable(
                // 右方向にリストアイテムをスライドした場合のアクション
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        // Todo編集画面に遷移する
                        _pushDiscountPriceInputPage(item);
                      },
                      backgroundColor: kColorGreen,
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
                          _discountStore.delete(item),
                          AddPrice(),
                        });
                      },
                      backgroundColor: kColorRed,
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
                    title: Row(
                      children: <Widget>[
                        Expanded(child: Text(item.discountProduct)),
                        Expanded(child: Text(item.discountPrice+" 円")),
                        Expanded(child: Text(item.discountNumber+item.discountMethod)),
                        //Expanded(child: Text(item.discountMethod)),
                        Expanded(child: Text(item.discountProductNumber)),
                        //Expanded(child: Text(item.discountMemo)),
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
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _pushDiscountPriceInputPage();
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kColorGreen,
        onPressed: _pushRegularPriceInputPage,
        child: const Icon(Icons.add),
      ),

    );
  }

  void _pushRegularPriceInputPage([RegularPrice? regularPrice]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return RegularPriceInputPage(regularPrice: regularPrice);
        },
      ),
    );
    //合計金額を計算し直す
    AddPrice();
    setState(() {});
  }

  void _pushDiscountPriceInputPage([DiscountPriceList? discountPriceList]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return DiscountPriceInputPage(discountPriceList: discountPriceList);
        },
      ),
    );
    //合計金額を計算し直す
    AddPrice();
    setState(() {});
  }

  //合計金額の計算
  void AddPrice(){
    //初期化
    sum=0;
    for(var i=0;i<_store.count();i++){
      var item = _store.finalByIndex(i);
      sum+=int.parse(item.number)*int.parse(item.price);
      print(sum);
    }

    for(var j=0;j<_discountStore.count();j++){
      var item=_discountStore.finalByIndex(j);
      //小数点以下を切り捨てるため
      double? floorItem;
      switch (item.discountMethod){
        case "割引":
          floorItem=int.parse(item.discountPrice)*(1-int.parse(item.discountNumber)*0.1)*int.parse(item.discountProductNumber);
          sum+=floorItem.floor();
          print(sum);
          break;
        case "%OFF":
          floorItem=int.parse(item.discountPrice)*(1-int.parse(item.discountNumber)*0.01)*int.parse(item.discountProductNumber);
          sum+=floorItem.floor();
          print(sum);
          break;
      }
    }
  }

}

