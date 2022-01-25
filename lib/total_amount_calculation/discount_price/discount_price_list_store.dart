import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../total_amount_calculation.dart';

class DiscountPriceListStore{
  final String _saveKey="DiscountPriceList";
  List<DiscountPriceList> _list=[];
  static final DiscountPriceListStore _instance=DiscountPriceListStore._internal();

  DiscountPriceListStore._internal();

  factory DiscountPriceListStore(){
    return _instance;
  }

  //割引商品リストの件数の取得
  int count(){
    return _list.length;
  }
  //指定したindexの商品の詳細を取得
  DiscountPriceList finalByIndex(int index){
    return _list[index];
  }
  //"yyyy/MM/dd HH:mm"形式で日時を取得する
  String getDateTime() {
    var format = DateFormat("yyyy/MM/dd HH:mm");
    var dateTime = format.format(DateTime.now());
    return dateTime;
  }
  //ローカルストレージにデータを追加する
  void add(String discountProduct,String discountPrice,String discountNumber,String discountMethod,String discountProductNumber,String discountMemo){
    var id = count() == 0 ? 1 : _list.last.id + 1;
    var dateTime = getDateTime();
    var discountPriceList=DiscountPriceList(id,discountProduct,discountPrice,discountNumber,discountMethod,discountProductNumber,discountMemo, dateTime, dateTime);
    _list.add(discountPriceList);
    save();
  }

  void update(DiscountPriceList discountPriceList,[String? discountProduct,String? discountPrice,String? discountNumber,String? discountMethod,String? discountProductNumber,String? discountMemo]){
    if(discountProduct!=null){
      discountPriceList.discountProduct=discountProduct;
    }
    if(discountPrice!=null){
      discountPriceList.discountPrice=discountPrice;
    }
    if(discountNumber!=null){
      discountPriceList.discountNumber=discountNumber;
    }
    if(discountMethod!=null){
      discountPriceList.discountMethod=discountMethod;
    }
    if(discountProductNumber!=null){
      discountPriceList.discountProductNumber=discountProductNumber;
    }
    if(discountMemo!=null){
      discountPriceList.discountMemo=discountMemo;
    }

    discountPriceList.updateDate=getDateTime();
    save();
  }

  void delete(DiscountPriceList discountPriceList) {
    _list.remove(discountPriceList);
    save();
  }

  void save() async {
    var prefs = await SharedPreferences.getInstance();
    // SharedPreferencesはプリミティブ型とString型リストしか扱えないため、以下の変換を行っている
    // TodoList形式 → Map形式 → JSON形式 → StringList形式
    var saveTargetList = _list.map((a) => json.encode(a.toJson())).toList();
    prefs.setStringList(_saveKey, saveTargetList);
  }

  void load() async {
    var prefs = await SharedPreferences.getInstance();
    // SharedPreferencesはプリミティブ型とString型リストしか扱えないため、以下の変換を行っている
    // StringList形式 → JSON形式 → Map形式 → TodoList形式
    var loadTargetList = prefs.getStringList(_saveKey) ?? [];
    _list = loadTargetList.map((a) => DiscountPriceList.fromJson(json.decode(a))).toList();
  }
}