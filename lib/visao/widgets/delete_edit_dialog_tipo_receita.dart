import 'package:flutter/material.dart';
import 'package:login_screen/controle/receita_controller.dart';
import 'package:login_screen/controle/tipo_receita_controller.dart';
import 'package:login_screen/modelo/beans/tipo_receita.dart';
import 'package:login_screen/visao/tipo_receita/edit_tipo_receita.dart';
import 'package:login_screen/visao/widgets/error_dialog.dart';
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
                        () => deletarTipoReceita(context),
                        () => null)
            );
          },
        ),
        TextButton(
          child: const Text('Editar'),
          onPressed: () =>
            Navigator.of(context)
              .push(
                MaterialPageRoute(builder: (context) => EditTipoReceita(_tipoReceita)
              )
            ).then((value) {
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

  deletarTipoReceita(context) {

    ReceitaContoller.existsByTipo(_tipoReceita.id)
      .then(
        (existencia) {
          if(!existencia){
            TipoReceitaContoller.delete(_tipoReceita.id)
              .then((value) {
              _onEnd();
              Navigator.of(context).pop();
            });
          }else{
            showDialog(
              context: context,
              builder: (context) =>
                ErrorDialog(
                  bodyText: 'Não é possível deletar  o registro de tipo de receita pois há receitas utilizando tal dado'
                )
            );
          }
      }
    );
  }
}
