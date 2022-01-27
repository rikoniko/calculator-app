import 'package:flutter/material.dart';

import 'calculation/calculation_page.dart';
import 'shopping_list/shopping_list_page.dart';
import 'total_amount_calculation/total_amount_calculation_page.dart';

const kColorPrimary = Color(0xFFFFDC80);
const kColorText = Color(0xFF182435);
const kColorBackground = Color(0xFFFFF9EA);
const kColorRed = Color(0xFFE36470);
const kColorGreen = Color(0xFF309398);
const kColorGrey = Color(0xFFF8F5EA);

class ButtonAria extends StatelessWidget {
  const ButtonAria({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 280,
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              ButtonTotalAmountCalculation(),
              ButtonShoppingList(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              ButtonCalculation(),
              ButtonShoppingList(),
            ],
          ),
        ],
      ),
    );
  }
}

class ButtonTotalAmountCalculation extends StatelessWidget {
  const ButtonTotalAmountCalculation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right:10),
        height: 130,
        color: kColorPrimary,
        child:ElevatedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                width: 55,
                image: AssetImage('assets/images/receipt.png'),
              ),
              SizedBox(height: 10),
              Text(
                'お会計',
                style: TextStyle(
                    color:kColorText,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
          style: ElevatedButton.styleFrom(
            primary: kColorBackground,
            elevation: 1,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TotalAmountCalculation()),
            );
          },
        )
      ),
    );
  }
}

class ButtonShoppingList extends StatelessWidget {
  const ButtonShoppingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 130,
        color: kColorPrimary,
          child:ElevatedButton(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  width: 58,
                  image: AssetImage('assets/images/shopping_cart.png'),
                ),
                SizedBox(height: 10),
                Text(
                  '買い物リスト',
                  style: TextStyle(
                      color:kColorText,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              primary: kColorBackground,
              elevation: 1,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShoppingListPage()),
              );
            },
          )
      ),
    );
  }
}

class ButtonCalculation extends StatelessWidget {
  const ButtonCalculation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right:10),
        height: 130,
        color: kColorPrimary,
          child:ElevatedButton(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  width: 58,
                  image: AssetImage('assets/images/calculation.png'),
                ),
                SizedBox(height: 10),
                Text(
                  '電卓',
                  style: TextStyle(
                      color:kColorText,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              primary: kColorBackground,
              elevation: 1,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalculationPage()),
              );
            },
          )
      ),
    );
  }
}
