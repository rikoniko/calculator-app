import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:calculator_app/total_amount_calculation/total_amount_calculation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegularPriceListStore{
  final String _saveKey="RegularPrice";
  List<RegularPrice> _list=[];
  static final RegularPriceListStore _instance=RegularPriceListStore._internal();

  RegularPriceListStore._internal();

  factory RegularPriceListStore(){
    return _instance;
  }

  //定価商品リストの件数の取得
  int count(){
    return _list.length;
  }
  //指定したindexの商品の詳細を取得
  RegularPrice finalByIndex(int index){
    return _list[index];
  }
  //"yyyy/MM/dd HH:mm"形式で日時を取得する
  String getDateTime() {
    var format = DateFormat("yyyy/MM/dd HH:mm");
    var dateTime = format.format(DateTime.now());
    return dateTime;
  }

  void add(String price,String number,String memo){
    var id = count() == 0 ? 1 : _list.last.id + 1;
    var dateTime = getDateTime();
    var regularPrice=RegularPrice(id, price, number, memo, dateTime, dateTime);
    _list.add(regularPrice);
    save();
  }

  void update(RegularPrice regularPrice,[String? price,String? number,String? memo]){
    if(price!=null){
      regularPrice.price=price;
    }
    if(number!=null){
      regularPrice.number=number;
    }
    if(memo!=null){
      regularPrice.memo=memo;
    }

    regularPrice.updateDate=getDateTime();
    save();
  }

  void delete(RegularPrice regularPrice) {
    _list.remove(regularPrice);
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
    _list = loadTargetList.map((a) => RegularPrice.fromJson(json.decode(a))).toList();
  }
}