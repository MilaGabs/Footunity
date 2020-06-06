class ProdutoObj {
  int id;
  String nome;
  String descricao;
  String imagem;
  double preco;

  ProdutoObj({this.id, this.nome, this.descricao, this.imagem, this.preco});

  factory ProdutoObj.fromJson(json){
    return ProdutoObj(
      id: int.parse(json['id']),
      nome: json['titulo'],
      descricao: json['descricao'],
      imagem: json['imagem'],
      preco: json['valor']
    );
  }
}