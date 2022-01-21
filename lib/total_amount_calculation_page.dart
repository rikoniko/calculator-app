import 'package:calculator_app/regular_price_list_add_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TotalAmountCalculation());
}

class TotalAmountCalculation extends StatefulWidget {
  const TotalAmountCalculation({Key? key}) : super(key: key);

  @override
  _TotalAmountCalculationState createState() => _TotalAmountCalculationState();
}

class _TotalAmountCalculationState extends State<TotalAmountCalculation> {

  List<String> regularPriceList=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("合計金額計算"),
      ),
      body: ListView.builder(
        itemCount: regularPriceList.length,
        itemBuilder: (context,index){
          /*return Card(
            child: ListTile(
              title: Text(regularPriceList[index]),
            ),
          );*/
          return DataTable(
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
            rows: <DataRow>[
              DataRow(
                  cells: <DataCell>[
                    DataCell(Text(regularPriceList[index])),
                    DataCell(Text('1')),
                    DataCell(Text('チョコ')),
                  ]
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final newListText=await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return RegularPriceListAddPage();
            }),
          );
          if(newListText!=null){
            setState(() {
              regularPriceList.add(newListText);
            });
          }
        },
         child: Icon(Icons.add),
      )
    );
  }
}


/*

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
*/