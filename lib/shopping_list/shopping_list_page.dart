import 'package:flutter/material.dart';
import 'shopping_list_add_page.dart';

const kColorPrimary = Color(0xFFFFDC80);
const kColorText = Color(0xFF182435);
const kColorBackground = Color(0xFFFFF9EA);
const kColorRed = Color(0xFFE36470);
const kColorGreen = Color(0xFF309398);
const kColorGrey = Color(0xFFF8F5EA);

void main() {
  runApp(const ShoppingListPage());
}

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {

  List<String> shoppingList=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:const Text(
            '買い物リスト',
            style: TextStyle(color:kColorText),
          ),
          backgroundColor:kColorPrimary,
        ),
        body: ListView.builder(
          itemCount: shoppingList.length,
          itemBuilder: (context,index){
            return Card(
            child: ListTile(
              title: Text(shoppingList[index]),
            ),
          );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kColorPrimary,
          onPressed: () async{
            final newListText=await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return const ShoppingListAddPage();
              }),
            );
            if(newListText!=null){
              setState(() {
                shoppingList.add(newListText);
              });
            }
          },
          child: const Icon(Icons.add,color: kColorText,),

        )
    );
  }
}
