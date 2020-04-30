import 'package:app_vendas_treino/classes/produto.dart';
import 'package:app_vendas_treino/mock/ProdutosApi.dart';
import 'package:flutter/material.dart';

class GridProdutos extends StatefulWidget{
  
  final state = new _ProdutoGridState();

  @override
  _ProdutoGridState createState() => state;
}

class _ProdutoGridState extends State<GridProdutos>{

  List _produtos = new List();
  var repositorio = new ProdutosApi();

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: Text('Footunity'),
        backgroundColor: Color(0xff5d0dff),
      ),
      body: new Container(
        child: _gridProdutoWidget(),
      ),
    );
  }

  Widget _gridProdutoWidget(){
    var grid = new GridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 2,
        
        children: List.generate(_produtos.length, (index) {
          return RaisedButton(
            child: _produtos[index],
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => QrCode()));
          }
        );
      }),
    );

    return grid;
  }
  
  @override
  void initState() {

    loadProdutos();

  }

  loadProdutos() async{

    List result = await repositorio.loadProduto();
    
    setState(() {

      result.forEach((item) {

        var notice = new Produto(
          item['tittle'],
          item['url_img'],
          item['price']
          // item['description']
        );


        _produtos.add(notice);

      });

    });

  }

}