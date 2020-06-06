import 'package:app_vendas_treino/classes/produtoObj.dart';
import 'package:flutter/material.dart';
// import 'package:simple_slider/simple_slider.dart';

class ProdutoPage extends StatefulWidget{
  
  final ProdutoObj produto;

  ProdutoPage({Key key, @required this.produto}) : super(key: key);

  @override
  _ProdutoState createState() => _ProdutoState(produto);
}

class _ProdutoState extends State<ProdutoPage>{
  ProdutoObj produto;

  _ProdutoState(this.produto);


  Widget _getImg(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            offset: Offset(2, 4),
            blurRadius: 5,
            spreadRadius: 2
          ),  
        ],
      ),
      child: Image.network(produto.imagem),
    );
  }

  Widget _title(){
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: produto.nome,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      )  
    );
  }

  Widget _getPreco(){
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: produto.preco.toString(),
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      )  
    );
  }

  String calculaParcela(double preco){
    double resultado;

    resultado = (preco/12);
    
    return resultado.toString();
  }

  Widget _getParcela(){

    String parcela;
    
    parcela = calculaParcela(produto.preco);

    return Container( 
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[  
          Icon(Icons.credit_card, color: Colors.purple),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: ' Em até 12xRS'+parcela+' sem juros',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.purple,
              ),
            )  
          ),
        ],
      ),  
    );  
  }

  Widget _getLine(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Divider(
        color: Colors.black26,
      ),
    );
  }

  Widget _getGarantia(){
    return Container( 
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[  
          Icon(Icons.check_circle, color: Colors.purple),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: ' Garantia de 90 dias.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.purple,
              ),
            )  
          ),
        ],
      ),  
    ); 
  }

  Widget _getDescricao(){
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Descricao',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      )  
    );
  }

  Widget _getConteudoDescricao(){
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: produto.descricao,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.black54,
        ),
      )  
    );
  } 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Footunity'),
          backgroundColor: Color(0xff5d0dff),
        ),
        body: _getPage(),
      ),
    );
  }

  Widget _getPage(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _getImg(),
                SizedBox(
                  height: 15,
                ),
                _title(),
                SizedBox(
                  height: 5,
                ),
                _getPreco(),
                _getLine(),
                _getParcela(),
                _getLine(),
                _getGarantia(),
                SizedBox(
                  height: 40,
                ),
               
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 _getDescricao(),
                SizedBox(
                  height: 10,
                ),
                _getConteudoDescricao(),
              ],
            )
          ),
        ],
      ),
    );
  }

}