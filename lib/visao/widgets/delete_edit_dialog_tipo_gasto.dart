import 'package:flutter/material.dart';
import 'package:login_screen/controle/tipo_gasto_controller.dart';
import 'package:login_screen/modelo/beans/tipo_gasto.dart';
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
                        () => TipoGastoContoller.delete(_tipoGasto.id)
                                .then((value) {
                                    _onEnd();
                                    Navigator.of(context).pop();
                                }),
                        () => null)
            );
          },
        ),
        TextButton(
          child: const Text('Editar'),
          onPressed: () {
            debugPrint('clicou para editar');//TODO
          },
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
}
