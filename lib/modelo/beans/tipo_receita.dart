class TipoReceita{
  final id;
  final nome;
  final descricao;

  TipoReceita({this.id, this.nome, this.descricao});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'descricao': descricao,
    };
  }

  @override
  String toString() {
    return 'TipoReceita(id: $id; nome: $nome; descricao: $descricao)';
  }

  static TipoReceita fromMap(Map<String, dynamic> map){
    return TipoReceita(
      id: map['id'], nome: map['nome'], descricao: map['descricao']
    );
  }
}