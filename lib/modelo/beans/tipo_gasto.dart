class TipoGasto {
  final id;
  final nome;
  final descricao;

  TipoGasto({this.id, this.nome, this.descricao});

  @override
  String toString() {
    return 'TipoGasto(id: $id; nome: $nome; descricao: $descricao)';
  }
}