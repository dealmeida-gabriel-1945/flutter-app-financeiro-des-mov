import 'package:flutter/material.dart';
import 'package:login_screen/controle/gasto_controller.dart';
import 'package:login_screen/modelo/beans/gasto.dart';
import 'package:login_screen/visao/gasto/edit_gasto.dart';
import 'package:login_screen/visao/widgets/yes_no_dialog.dart';

class DeleteEditDialogGasto extends StatelessWidget {

  final Gasto _gasto;
  final _onEnd;


  DeleteEditDialogGasto(this._gasto, this._onEnd);

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
                        () => GastoContoller.delete(_gasto.id)
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
          onPressed: () =>
            Navigator.of(context)
                .push(
                MaterialPageRoute(builder: (context) => EditGasto(_gasto)
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
}
