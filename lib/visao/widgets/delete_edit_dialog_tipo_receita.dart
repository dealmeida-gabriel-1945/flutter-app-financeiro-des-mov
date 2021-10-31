import 'package:flutter/material.dart';
import 'package:login_screen/modelo/beans/tipo_receita.dart';

class DeleteEditDialogTipoReceita extends StatelessWidget {

  final TipoReceita _tipoReceita;


  DeleteEditDialogTipoReceita(this._tipoReceita);

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
            debugPrint('clicou para excluir');//TODO
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
