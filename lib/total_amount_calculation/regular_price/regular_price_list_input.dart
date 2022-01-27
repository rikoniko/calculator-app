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
  //商品の個数表示用
  int count=0;
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
    setState(() {});
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
    //商品の個数を初期化する
    InitProductNumber();
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
              ///商品名
              ProductNameArea(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    ///値段
                    Expanded(flex:2,child: ProductPriceArea(),),
                    const SizedBox(width: 20,),
                    const Expanded(flex:1,child: Text("円", style: TextStyle(color:kColorText,fontSize: 18,))),
                    ///個数
                    Expanded(flex:2,child: ProductNumberArea(context, changeValue: (isIncrement){
                      if(isIncrement){
                        count++;
                        _number=count.toString();
                        setState(() {});
                      }else{
                        count--;
                        _number=count.toString();
                        setState(() {});
                      }
                    }),),
                  ],
                ),
              ),
              ///メモ
              MemoArea(),
              /// 追加ボタン
              AddButtonArea(),
              /// キャンセルボタン
              CancellButtonArea(),
            ],
          ),
        ),
      ),
    ),
  );

  Widget ProductNameArea() {
    return isLoading? const Center(child: CircularProgressIndicator(),):Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Autocomplete(
            optionsBuilder: (TextEditingValue textEditingValue){
              TextEditingController(text: _product);
              if(textEditingValue.text.isEmpty){
                return const Iterable<String>.empty();
              }else{
                return autoCompleteData.where((word) => word.contains(textEditingValue.text));
              }
            },
            onSelected: (String selectedString){
              _product=selectedString;
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
                  controller: textEditingController..text=_product,
                  //controller: TextEditingController(text: _product),
                  onChanged: (String value) {
                    _product = value;
                  },
                );
            },
          )
        ],

      ),
    );
  }

  Widget ProductPriceArea() {
    return TextField(
      keyboardType: TextInputType.number,
      //autofocus: true,
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
      controller: TextEditingController(text: _price),
      onChanged: (String value) {
        _price = value;
      },
    );
  }

  Widget ProductNumberArea(BuildContext context, {double width = 80, double height = 40, required void Function(bool isIncrement) changeValue}) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kColorPrimary,
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
            Text("$count",style: const TextStyle(color:kColorText,fontSize: 17, fontWeight: FontWeight.bold,)),
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

  Widget MemoArea() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
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
        controller: TextEditingController(text: _memo),
        onChanged: (String value) {
          _memo = value;
        },
      ),
    );
  }

  Widget AddButtonArea() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
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
            style: const TextStyle(color: kColorText,fontSize: 17,),
          ),
          style: ElevatedButton.styleFrom(
            primary: kColorPrimary,
            elevation: 0.5,
            fixedSize: const Size(100, 45),
            shape: const StadiumBorder(),
          ),
        ),
      ),
    );
  }

  Widget CancellButtonArea() {
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () {
            // Todoリスト画面に戻る
            Navigator.of(context).pop();
          },
          child: const Text(
            "キャンセル",
            style: TextStyle(color: kColorText,fontSize: 16),
          ),
          style: OutlinedButton.styleFrom(
            primary: kColorPrimary,
            fixedSize: const Size(100, 45),
            shape: const StadiumBorder(),
          ),
        ),
      ),
    );
  }

  void InitProductNumber() {
    if(_number==""){
      count=1;
    }else{
      count=int.parse(_number);
    }
  }


}
