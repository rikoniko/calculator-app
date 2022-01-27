import "package:flutter_test/flutter_test.dart";

void main() {
  test('total amount calculation unit test', () {
    String productNumber="1";
    String productPrice="200";
    String discountNumber="50";
    String discountMethod="%OFF";
    double? floorItem;
    int sum=0;

    switch (discountMethod){
      case "割引":
        floorItem=int.parse(productPrice)*(1-int.parse(discountNumber)*0.1)*int.parse(productNumber);
        sum+=floorItem.floor();
        break;
      case "%OFF":
        floorItem=int.parse(productPrice)*(1-int.parse(discountNumber)*0.01)*int.parse(productNumber);
        sum+=floorItem.floor();
        break;
    }

    expect(sum,100);
  });
}