
import 'package:app_vendas_treino/pages/qrCode.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{

  static String tag = 'home-page';

  @override
  HomePageState createState() {
    return new HomePageState();
  }
}
    
class HomePageState extends State<HomePage>{
 @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new ListaScreen(), 
    );
  }
}

class ListaScreen extends StatelessWidget{

  Widget getItem() {
    return new Row(
      children: [
        IconButton(
          icon: new Icon(Icons.check_box, color: Colors.green),
          iconSize: 42.0, 
          onPressed: (){},
        ),
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Texto"),
            Text("Data"),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Footunity"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.white), 
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => QrCode()));
            }
          )
        ],
      ),
      // body: Row(  
      //   children: <Widget>[
      //     ConstrainedBox(
      //       constraints: BoxConstraints(
      //         maxWidth: 200,
      //       ),
      //        child: Text(
      //          "Bem-Vindo",
      //          textAlign: TextAlign.center,
      //        ),
      //     ),  
      //   ],
      // ),
      body: Center(
        child: Text("Bem-Vindo ao Footunity")
      ),
    );
  }

}