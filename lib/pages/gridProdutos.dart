import 'dart:convert';

import 'package:app_vendas_treino/classes/produtoObj.dart';
import 'package:app_vendas_treino/mock/ProdutosApi.dart';
import 'package:app_vendas_treino/pages/produtoPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../shared/sharedConstants.dart' as constants;

class GridProdutos extends StatefulWidget{
  
  final state = new _ProdutoGridState();

  @override
  _ProdutoGridState createState() => state;
}

Future<List<ProdutoObj>> getProdutos() async {
  var prefs = await SharedPreferences.getInstance();
  var reqHeader = { 
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + prefs.getString(constants.LoginKey),
      'Access-Control-Allow-Origin': '*'
  };
  var url = constants.FootAPILink + 'produto/obtergridprodutos';
  var response = await http.get(url, headers: reqHeader);
  if(response.statusCode == 200){
    Iterable parsed = jsonDecode(response.body);
    var retorno = List<ProdutoObj>.from(parsed.map((e) => ProdutoObj.fromJson(e)));
    return retorno;
  }
}

class _ProdutoGridState extends State<GridProdutos>{

  List _produtos = new List();
  var repositorio = new ProdutosApi();

  @override
  Widget build(BuildContext context) {
    getProdutos();
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Footunity'),
        backgroundColor: Color(0xff5d0dff),
      ),
      body: new Container(
        child: FutureBuilder(
          future: getProdutos(),
          builder: (context, AsyncSnapshot<List<ProdutoObj>> snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              _produtos = snapshot.data;
              return _gridProdutoWidget();
            }
            else{
              return CircularProgressIndicator();
            }
          },
        )
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
          return InkWell(
            child: _produtos[index],
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProdutoPage(produto: _produtos[index])));
          }
        );
      }),
    );

    return grid;
  }
}