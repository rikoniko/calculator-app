
const c_op = ['+', '-', '×', '÷'];

class Calculator{
  static var number = <double>[];
  static var op = <String>[];
  static var buffer;

  static void GetKey(String letter){
    // 数字と符号を分割
    if(c_op.contains(letter)){
      op.add(letter);
      //String型からdouble型に変換
      number.add(double.parse(buffer));

      print('number:$number');
      buffer = '';
    } // C
    else if(letter == 'C'){
      number.clear();
      op.clear();
      buffer = '';
    } // =
    else if(letter == '='){
      return null;
    }// 数字
    else{
      buffer += letter;
    }
  }

  //四則演算
  static String Execute() {
    double tmp;
    double result=0.0;

    number.add(double.parse(buffer));
    if (number.length == 0) {
      return '0';
    }
    for (var i = 0; i < op.length; i++) {
      switch (op[i]) {
        case '×':
          tmp = number[i] * number[i + 1];
          number[i] = 0.0;
          number[i + 1] = tmp;
          break;
        case '÷':
          tmp = number[i] / number[i + 1];
          number[i] = 0.0;
          number[i + 1] = tmp;
          break;
        case '-':
          number[i + 1] = number[i + 1] * -1.0;
          break;
      }
    }

    //最後に全て足す
    for (double num in number) {
      result += num;
    }
    //print('結果：$result');
    number.clear();
    op.clear();
    buffer = '';

    var resultStr = result.toString().split('.');
    return resultStr[1] == '0' ? resultStr[0] : result.toString();
  }
}