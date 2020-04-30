import 'package:app_vendas_treino/pages/homePage.dart';
import 'package:app_vendas_treino/pages/itemsPage.dart';
import 'package:flutter/material.dart';

class QrCode extends StatefulWidget{

  static String tag = 'qr-code';

  @override
  QrCodeState createState() {
    return new QrCodeState();
  }
}
    
class QrCodeState extends State<QrCode>{
 @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new ListaScreen(), 
    );
  }
}

class ListaScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Qr Code"),
        backgroundColor: Color(0xff5d0dff),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back, 
            color: Colors.white
            ), 
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            }
          )
        
      ),
      body: Center(
        child: RaisedButton(
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ItemsPage()));},
          child: Text("Ir para Itens"),
        ),
      ),
    );
  }

}