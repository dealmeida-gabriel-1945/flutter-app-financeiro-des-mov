import 'package:login_screen/modelo/beans/tipo_receita.dart';
import 'package:login_screen/util/database_constants.dart';
import 'package:login_screen/util/date_util.dart';

class Receita{
  final id;
  final String observacoes;
  final dataHora;
  final valor;
  final TipoReceita tipo;

  Receita(this.id, this.observacoes, this.dataHora, this.valor, this.tipo);

  bool valido(){
    return !((observacoes.length > DatabaseConstants.text_column_size)
      || (valor <= 0) || (tipo.id == null));
  }

  Map<String, dynamic> toMap() {
    return {
      'observacoes': observacoes,
      'data_hora': DateUtil.dateToDatabase(dataHora),
      'valor': valor,
      'tipo_receita_id': tipo.id,
    };
  }

  @override
  String toString() {
    return 'Receita(id: $id; observacoes: $observacoes; datahora: $dataHora, valor: $valor; tipo: $tipo)';
  }

  static Receita fromMap(Map<String, dynamic> map){
    return Receita(
        map['id'],
        map['observacoes'],
        DateUtil.dateFromDatabaseToDartDateTime(map['data_hora']),
        map['valor'],
        TipoReceita(
          id: map['tipoId'],
          nome: map['tipoNome'],
          descricao: map['tipoDescricao'],
        )
    );
  }
}