import 'package:flutter/material.dart';
import 'package:login_screen/controle/receita_controller.dart';
import 'package:login_screen/modelo/beans/receita.dart';
import 'package:login_screen/visao/receita/edit_receita.dart';
import 'package:login_screen/visao/widgets/yes_no_dialog.dart';

class DeleteEditDialogReceita extends StatelessWidget {

  final Receita _receita;
  final _onEnd;


  DeleteEditDialogReceita(this._receita, this._onEnd);

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
                        () => ReceitaContoller.delete(_receita.id)
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
                  MaterialPageRoute(builder: (context) => EditReceita(_receita)
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
