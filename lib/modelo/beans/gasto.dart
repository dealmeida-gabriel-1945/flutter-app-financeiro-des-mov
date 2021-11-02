import 'package:login_screen/modelo/beans/tipo_gasto.dart';
import 'package:login_screen/util/database_constants.dart';
import 'package:login_screen/util/date_util.dart';

class Gasto {
  final id;
  final TipoGasto tipo;
  final observacoes;
  final dataHora;
  final valor;

  Gasto(this.id, this.observacoes, this.dataHora, this.valor, this.tipo);

  bool valido(){
    return !((observacoes.length > DatabaseConstants.text_column_size)
        || (valor <= 0) || (tipo.id == null));
  }

  Map<String, dynamic> toMap() {
    return {
      'observacoes': observacoes,
      'data_hora': DateUtil.dateToDatabase(dataHora),
      'valor': valor,
      'tipo_gasto_id': tipo.id,
    };
  }

  @override
  String toString() {
    return 'Gasto(id: $id; observacoes: $observacoes; datahora: $dataHora, valor: $valor; tipo: $tipo)';
  }

  static Gasto fromMap(Map<String, dynamic> map){
    return Gasto(
        map['id'],
        map['observacoes'],
        DateUtil.dateFromDatabaseToDartDateTime(map['data_hora']),
        map['valor'],
        TipoGasto(
          id: map['tipoId'],
          nome: map['tipoNome'],
          descricao: map['tipoDescricao'],
        )
    );
  }
}