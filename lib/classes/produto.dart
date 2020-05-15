import 'package:app_vendas_treino/classes/produtoObj.dart';
import 'package:flutter/material.dart';

class Produto extends StatelessWidget{

  ProdutoObj produtoObj;

  Produto(this.produtoObj);

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return new Container(
      // margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0, top: 0.0),
      child: new Material(
        borderRadius: new BorderRadius.circular(6.0),
        elevation: 2.0,
        child: _getInfo(),
      ),
    );
  }

  Widget _getInfo(){
    return new Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new FadeInImage.assetNetwork(placeholder: '', image: produtoObj.imagem,fit: BoxFit.cover),
          _getColumnText(produtoObj.nome,produtoObj.preco),
        ],
      ),
    );
  }

  Widget _getColumnText(title,price){
    return new Expanded(
      child: Container(
        margin: new EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getTitle(title),
            _getPrice(price.toString()),
            // _getParcela(),
          ],
        ),
      ),
    );
  }

  Widget _getTitle(String title){
    return new Text(
      title,
      maxLines: 2,
      style: new TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _getPrice(String price){
    return new Text(
      'RS '+price,
      maxLines: 1
      // style: new TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _getParcela(){
    return new Text(
      'Em até 12x sem juros',
      maxLines: 1,
      style: new TextStyle(fontSize:13),
    );
  }
}