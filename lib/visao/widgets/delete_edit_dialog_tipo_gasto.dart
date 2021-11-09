import 'package:flutter/material.dart';
import 'package:login_screen/controle/gasto_controller.dart';
import 'package:login_screen/controle/tipo_gasto_controller.dart';
import 'package:login_screen/modelo/beans/tipo_gasto.dart';
import 'package:login_screen/visao/tipo_gasto/edit_tipo_gasto.dart';
import 'package:login_screen/visao/widgets/error_dialog.dart';
import 'package:login_screen/visao/widgets/yes_no_dialog.dart';

class DeleteEditDialogTipoGasto extends StatelessWidget {

  final TipoGasto _tipoGasto;
  final _onEnd;


  DeleteEditDialogTipoGasto(this._tipoGasto, this._onEnd);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Atenção!'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('O que você deseja realizar com o tipo de gasto?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Excluir'),
          onPressed: () {
            showDialog(
                context: context,
                builder:
                  (context) => YesNoDialog(
                        () => deletarTipoGasto(context),
                        () => null)
            );
          },
        ),
        TextButton(
          child: const Text('Editar'),
          onPressed: () =>
            Navigator.of(context)
              .push(
                  MaterialPageRoute(builder: (context) => EditTipoGasto(_tipoGasto)
              )).then((value) {
                Navigator.of(context).pop();
                _onEnd();
              }),
        ),
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  deletarTipoGasto(context){
    GastoContoller.existsByTipo(_tipoGasto.id)
      .then(
        (existencia) {
          if(!existencia){
            TipoGastoContoller.delete(_tipoGasto.id)
                .then((value) {
              _onEnd();
              Navigator.of(context).pop();
            });
          }else{
            showDialog(
              context: context,
              builder: (context) =>
                ErrorDialog(
                  bodyText: 'Não é possível deletar  o registro de tipo de gasto pois há gastos utilizando tal dado'
                )
            );
          }
        }
    );
  }
}
