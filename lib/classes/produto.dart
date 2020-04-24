import 'package:flutter/material.dart';

class Produto extends StatelessWidget{

  var _img;
  var _title;
  // var _descricao;
  var _price;

  Produto(this._title, this._img, this._price);

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return new Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 0.0),
      child: new Material(
        borderRadius: new BorderRadius.circular(6.0),
        elevation: 2.0,
        child: _getInfo(),
      ),
    );
  }

  Widget _getInfo(){
    return new Container(
      height: 95.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new FadeInImage.assetNetwork(placeholder: '', image: _img,fit: BoxFit.cover,width: 95.0,height: 95.0,),
          _getColumnText(_title,_price),
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
            _getPrice(price),
          ],
        ),
      ),
    );
  }

  Widget _getTitle(String title){
    return new Text(
      title,
      maxLines: 1,
      style: new TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _getPrice(String price){
    return new Text(
      price,
      maxLines: 1
      // style: new TextStyle(fontWeight: FontWeight.bold),
    );
  }
}