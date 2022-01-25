class RegularPrice{
  late int id;
  late String price;
  late String number;
  late String memo;
  late String createDate;
  late String updateDate;

  RegularPrice(
      this.id,
      this.price,
      this.number,
      this.memo,
      this.createDate,
      this.updateDate,
      );

  Map toJson(){
    return{
      'id':id,
      'price':price,
      'number':number,
      'memo':memo,
      'createDate':createDate,
      'updateDate':updateDate
    };
  }

  RegularPrice.fromJson(Map json){
    id=json['id'];
    price=json['price'];
    number=json['number'];
    memo=json['memo'];
    createDate=json['createDate'];
    updateDate=json['updateDate'];
  }
}

class DiscountPriceList{
  late int id;
  late String discountProduct;
  late String discountPrice;
  late String discountNumber;
  late String discountMethod;
  late String discountProductNumber;
  late String discountMemo;
  late String createDate;
  late String updateDate;

  DiscountPriceList(
      this.id,
      this.discountProduct,
      this.discountPrice,
      this.discountNumber,
      this.discountMethod,
      this.discountProductNumber,
      this.discountMemo,
      this.createDate,
      this.updateDate,
      );

  Map toJson(){
    return{
      'id':id,
      'discountProduct':discountProduct,
      'discountPrice':discountPrice,
      'discountNumber':discountNumber,
      'discountMethod':discountMethod,
      'discountProductNumber':discountProductNumber,
      'discountMemo':discountMemo,
      'createDate':createDate,
      'updateDate':updateDate
    };
  }

  DiscountPriceList.fromJson(Map json){
    id=json['id'];
    discountProduct=json['discountProduct'];
    discountPrice=json['discountPrice'];
    discountNumber=json['discountNumber'];
    discountMethod=json['discountMethod'];
    discountProductNumber=json['discountProductNumber'];
    discountMemo=json['discountMemo'];
    createDate=json['createDate'];
    updateDate=json['updateDate'];
  }
}