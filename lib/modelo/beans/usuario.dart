import 'package:login_screen/util/database_constants.dart';
import 'package:login_screen/util/date_util.dart';

class Usuario {
  final id;
  final nome;
  final sobrenome;
  final dataNascimento;
  final cpf;
  final senha;

  Usuario({
    this.id, this.nome, this.sobrenome, this.dataNascimento, this.cpf,
    this.senha
  });

  bool valido(){
    return (nome.length >= DatabaseConstants.varchar_column_min_size)
        && (nome.length <= DatabaseConstants.varchar_column_max_size)
        && (sobrenome.length >= DatabaseConstants.varchar_column_min_size)
        && (sobrenome.length <= (DatabaseConstants.varchar_column_max_size * 2))
        && (cpf.length == DatabaseConstants.cpf_column_max_size)
        && (senha.length >= DatabaseConstants.varchar_column_min_size)
        && (senha.length <= (2 * DatabaseConstants.varchar_column_max_size));
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'sobrenome': sobrenome,
      'data_nascimento': DateUtil.dateToDatabase(dataNascimento),
      'cpf': cpf,
      'senha': senha,
    };
  }

  @override
  String toString() {
    return 'Usuario(id: $id; nome: $nome; sobrenome: $sobrenome;'
        ' data_nascimento: $dataNascimento; cpf: $cpf )';
  }

  static Usuario fromMap(Map<String, dynamic> map){
    return Usuario(
        id: map['id'], nome: map['nome'], sobrenome: map['sobrenome'],
        dataNascimento: DateUtil.dateFromDatabaseToDartDateTime(map['dataNascimento']),
        cpf: map['cpf'],
    );
  }
}