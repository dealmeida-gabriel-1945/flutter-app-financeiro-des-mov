import 'package:login_screen/util/database_constants.dart';

class TipoGasto {
  final id;
  final nome;
  final descricao;

  TipoGasto({this.id, this.nome, this.descricao});

  bool valido(){
    return (nome.length > 5)
        && (nome.length <= DatabaseConstants.varchar_column_size)
        && (descricao.length <= DatabaseConstants.varchar_column_size);
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'descricao': descricao,
    };
  }

  @override
  String toString() {
    return 'TipoGasto(id: $id; nome: $nome; descricao: $descricao)';
  }

  static TipoGasto fromMap(Map<String, dynamic> map){
    return TipoGasto(
        id: map['id'], nome: map['nome'], descricao: map['descricao']
    );
  }
}