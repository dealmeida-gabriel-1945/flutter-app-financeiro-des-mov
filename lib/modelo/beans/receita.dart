import 'package:login_screen/modelo/beans/tipo_gasto.dart';

class Receita{
  final id;
  final observacoes;
  final dataHora;
  final valor;
  final TipoGasto tipo;

  Receita(this.id, this.observacoes, this.dataHora, this.valor, this.tipo);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'observacoes': observacoes,
      'data_hora': dataHora,
      'valor': valor,
      'tipo_gasto_id': tipo.id,
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
        map['data_hora'],
        map['valor'],
        TipoGasto(id: map['tipo_gasto_id'])
    );
  }
}