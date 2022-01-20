import 'package:calculator_app/regular_price_list_add_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TotalAmountCalculation());
}

class TotalAmountCalculation extends StatelessWidget {
  const TotalAmountCalculation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('合計金額計算'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          RegularPriceList()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return RegularPriceListAddPage();
            }),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

}

class RegularPriceList extends StatelessWidget {
  const RegularPriceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                '１つの値段',
              ),
            ),
            DataColumn(
              label: Text(
                '個',
              ),
            ),
            DataColumn(
              label: Text(
                'メモ',
              ),
            ),
          ],
          rows: const <DataRow>[
            DataRow(
                cells: <DataCell>[
                  DataCell(Text('200')),
                  DataCell(Text('1')),
                  DataCell(Text('チョコ')),
                ]
            ),
            DataRow(
                cells: <DataCell>[
                  DataCell(Text('300')),
                  DataCell(Text('2')),
                  DataCell(Text('豚肉')),
                ]
            ),
          ],
        )
    );
  }
}
