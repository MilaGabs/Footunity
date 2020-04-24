import 'package:app_vendas_treino/classes/gridProdutos.dart';
import 'package:app_vendas_treino/pages/qrCode.dart';
import 'package:flutter/material.dart';

class ItemsPage extends StatefulWidget{

  static String tag = 'items-page';

  @override
  ItemsPageState createState() {
    return new ItemsPageState();
  }
}
    
class ItemsPageState extends State<ItemsPage>{
 @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new GridProdutos(), 
    );
  }
}

class ListItems extends StatelessWidget{

  Widget getItem() {
    return new Column(
      children:  <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          child:  Image.network('https://i8.amplience.net/i/jpl/jd_009289_a?qlt=92'),
        ),
        Text("Nike 270"),
        Text("Teste")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
         title: new Text("Footunity"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back, 
            color: Colors.white
            ), 
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => QrCode()));
            }
          )
      ),
      body:  GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(100, (index) {
            return RaisedButton(
              child: Container(
                child: getItem(),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => QrCode()));
              }
            );
          }),
        ),
      );
  }

  

}