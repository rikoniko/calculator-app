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