import 'package:flutter/material.dart';
import 'package:login_screen/controle/tipo_receita_controller.dart';
import 'package:login_screen/modelo/beans/tipo_receita.dart';
import 'package:login_screen/visao/widgets/yes_no_dialog.dart';

class DeleteEditDialogTipoReceita extends StatelessWidget {

  final TipoReceita _tipoReceita;
  final _onEnd;


  DeleteEditDialogTipoReceita(this._tipoReceita, this._onEnd);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Atenção!'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('O que você deseja realizar com o tipo de receita?'),
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
                        () => TipoReceitaContoller.delete(_tipoReceita.id)
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
