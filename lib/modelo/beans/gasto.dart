import 'package:login_screen/modelo/beans/tipo_gasto.dart';

class Gasto {
  final id;
  final TipoGasto tipoGasto;
  final observacoes;
  final dataHora;
  final valor;

  Gasto(this.id, this.tipoGasto, this.observacoes, this.dataHora, this.valor);
}