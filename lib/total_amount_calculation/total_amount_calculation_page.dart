import 'package:calculator_app/total_amount_calculation/product_list.dart';
import 'package:calculator_app/total_amount_calculation/products.dart';
import 'package:calculator_app/total_amount_calculation/regular_price_list_add_page.dart';
import 'package:calculator_app/utils.dart';
import 'package:flutter/material.dart';

/*void main() {
  runApp(TotalAmountCalculation());
}*/

class TotalAmountCalculation extends StatefulWidget {
  //const TotalAmountCalculation({Key? key}) : super(key: key);

  final String price;
  final String number;
  final String text;

  const TotalAmountCalculation({
    Key? key,
    required this.price,
    required this.number,
    required this.text,
  }) : super(key: key);

  @override
  _TotalAmountCalculationState createState() => _TotalAmountCalculationState();
}

class _TotalAmountCalculationState extends State<TotalAmountCalculation> {
  late List<Product> products;
  static List<String> regularPriceList = [];


  @override
  void initState() {
    super.initState();
    this.products = List.of(allProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('合計金額計算'),
        ),
        body: buildDateTable(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final newListText = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return const RegularPriceListAddPage();
              }),
            );
            print('$context');
          if (newListText != null) {
            setState(() {
            _TotalAmountCalculationState.regularPriceList.add(newListText);
          });
          print('$_TotalAmountCalculationState.regularPriceList');

          }
          },
          child: Icon(Icons.add),
        ),

    );
  }

  Widget buildDateTable() {
    final colums = ["値段", "個数", "メモ"];

    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columns: getColumns(colums),
        rows: getRows(products),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String coloum) {
      return DataColumn(
        label: Text(coloum),
      );
    }).toList();
  }

  //productsに全てのデータが入っているから、そこから取り出せるようにする
  List<DataRow> getRows(List<Product> products) {
    return products.map((Product product) {
      final cells = [product.price, product.number, product.text];

      return DataRow(
        cells: Utils.modelBuilder(cells, (index, cell) {
          return DataCell(
            Text('$cell'),
          );
        }),
      );
    }).toList();
  }
}

/*class NextPage extends StatefulWidget {

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final newListText = await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return const RegularPriceListAddPage();
          }),
        );
        print('$context');
        if (newListText != null) {
          setState(() {
            _TotalAmountCalculationState.regularPriceList.add(newListText);
          });
          print('$_TotalAmountCalculationState.regularPriceList');

        }
      },
      child: Icon(Icons.add),
    );
  }
}
*/
  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("合計金額計算"),
      ),
      body: ListView.builder(
        itemCount: regularPriceList.length,
        itemBuilder: (context,index){
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
  }*/



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