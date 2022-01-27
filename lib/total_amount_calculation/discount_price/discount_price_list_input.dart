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
  int count=0;

  final methodItems=['割引','%OFF'];
  String? methodValue='割引';

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
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    ///値段
                    Expanded(flex:3,child: DiscountProductPriceArea()),
                    const SizedBox(width: 15,),
                    const Expanded(flex:2,child: Text("円の", style: TextStyle(color:kColorText,fontSize: 18,))),
                    ///何％OFF・割引
                    Expanded(flex:2,child: DiscountNumberArea()),
                    const SizedBox(width: 15,),
                    ///％OFFor割引
                    Expanded(flex:3,child: DiscountMethodArea()),
                  ],
                ),
              ),
              ///個数
              ProductNumberArea(context, changeValue: (isIncrement){
                WidgetsBinding.instance!.addPostFrameCallback((_){
                  if(isIncrement){
                    count++;
                    _discountProductNumber=count.toString();
                    setState(() {});
                  }else{
                    count--;
                    _discountProductNumber=count.toString();
                    setState(() {});
                  }
                });
              }),
              /// メモ
              DiscountProductMemo(),
              /// 追加/更新ボタン
              AddButtonArea(),
              /// キャンセルボタン
              CancellButtonArea(),
            ],
          ),
        ),
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

  Widget ProductNumberArea(BuildContext context, {double width = 150, double height = 40, required void Function(bool isIncrement) changeValue}) {
    return Padding(
      padding: const EdgeInsets.only(left: 150),
      child: SizedBox(
        width: width,
        height: height,
        child: Container(
          alignment: Alignment.centerRight,
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
                          child: Icon(Icons.remove, size: 24, color: kColorText),
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
                          child: Icon(Icons.add, size: 24, color: kColorText),
                        ),
                      )
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  void InitProductNumber() {
    if(_discountProductNumber==""){
      count=1;
    }else{
      count=int.parse(_discountProductNumber);
    }
  }

  Widget DiscountProductPriceArea() {
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
      controller: TextEditingController(text: _discountPrice),
      onChanged: (String value) {
        _discountPrice = value;
      },
    );
  }

  Widget DiscountNumberArea() {
    return TextField(
      keyboardType: TextInputType.number,
      //autofocus: true,
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
    );
  }

  Widget DiscountMethodArea() {
    return DropdownButton(
      value: methodValue,
      items: methodItems.map(buildMenuItem).toList(),
      onChanged: (value){
        setState(() {
          methodValue=value as String?;
          _discountMethod=value!;
        });
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(String method)=> DropdownMenuItem(
    value: method,
    child: Text(
      method,
      style: const TextStyle(
        //fontWeight: FontWeight.bold,
        //fontSize: 20,
      ),
    ),
  );

  Widget DiscountProductMemo() {
    return Padding(
      padding: const EdgeInsets.all(16),
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
        controller: TextEditingController(text: _discountMemo),
        onChanged: (String value) {
          _discountMemo = value;
        },
      ),
    );
  }

  Widget AddButtonArea() {
    return  Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox(
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
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
          },
          child: Text(
            _isCreateDiscountPrice ? '追加' : '更新',
            style: const TextStyle(color: kColorText,fontSize: 17,),
          ),
          style: ElevatedButton.styleFrom(
            primary: kColorPrimary,
            elevation: 0.5,
            fixedSize: const Size(200, 45),
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

}
