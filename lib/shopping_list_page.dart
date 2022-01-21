import 'package:calculator_app/regular_price_list_add_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ShoppingListPage());
}

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {

  List<String> regularPriceList=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("買い物リスト"),
        ),
        body: ListView.builder(
          itemCount: regularPriceList.length,
          itemBuilder: (context,index){
            return Card(
            child: ListTile(
              title: Text(regularPriceList[index]),
            ),
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
