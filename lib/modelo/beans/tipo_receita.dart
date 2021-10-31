class TipoReceita{
  final id;
  final nome;
  final descricao;

  TipoReceita({this.id, this.nome, this.descricao});

  @override
  String toString() {
    return 'TipoReceita(id: $id; nome: $nome; descricao: $descricao)';
  }
}