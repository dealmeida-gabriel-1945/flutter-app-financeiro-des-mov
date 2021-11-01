import 'package:login_screen/util/database_constants.dart';

class TipoReceita{
  final id;
  final nome;
  final descricao;

  TipoReceita({this.id, this.nome, this.descricao});

  bool valido(){
    return (nome.length >= DatabaseConstants.varchar_column_min_size)
        && (nome.length <= DatabaseConstants.varchar_column_max_size)
        && (descricao.length <= DatabaseConstants.text_column_size);
  }

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