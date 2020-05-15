import 'package:app_vendas_treino/classes/produto.dart';
import 'package:app_vendas_treino/classes/produtoObj.dart';
import 'package:app_vendas_treino/mock/ProdutosApi.dart';
import 'package:app_vendas_treino/pages/produtoPage.dart';
import 'package:flutter/material.dart';

class GridProdutos extends StatefulWidget{
  
  final state = new _ProdutoGridState();

  @override
  _ProdutoGridState createState() => state;
}

class _ProdutoGridState extends State<GridProdutos>{

  List _produtos = new List();
  List _produtoObj = new List();
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
          return InkWell(
            child: _produtos[index],
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProdutoPage(produto: _produtoObj[index])));
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

  void loadProdutos(){
    ProdutoObj produto1 = ProdutoObj();
    ProdutoObj produto2 = ProdutoObj();

    produto1.id = 1;
    produto1.nome = 'Tenis Nike 270';
    produto1.imagem = 'https://i8.amplience.net/i/jpl/jd_009289_a?qlt=92';
    produto1.preco = 120;
    produto1.descricao = 'Este produto foi desenvolvido pela fabricante Nike.';

    produto2.id = 2;
    produto2.nome = 'Nike 270';
    produto2.imagem = 'https://i8.amplience.net/i/jpl/jd_009289_a?qlt=92';
    produto2.preco = 1200;
    produto2.descricao = 'Tenis nike, excelencia em qualidade e conforto.';

    var produtoItem1 = new Produto(produto1);
    var produtoItem2 = new Produto(produto2);

    _produtos.add(produtoItem1);
    _produtos.add(produtoItem2);
    _produtoObj.add(produto1);
    _produtoObj.add(produto2);
  }

  // loadProdutos() async{

  //   List result = await repositorio.loadProduto();
    
  //   setState(() {

  //     result.forEach((item) {

  //       var produto = new Produto(
  //         item['tittle'],
  //         item['url_img'],
  //         item['price']
  //         // item['description']
  //       );

  //       _produtos.add(produto);

  //     });

  //   });

  // }

}