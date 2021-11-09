
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_screen/controle/tipo_receita_controller.dart';
import 'package:login_screen/modelo/beans/tipo_receita.dart';
import 'package:login_screen/visao/widgets/error_dialog.dart';

class EditTipoReceita extends StatefulWidget {

  final TipoReceita _tipoReceita;

  EditTipoReceita(this._tipoReceita);

  @override
  _EditTipoReceitaState createState() => _EditTipoReceitaState(_tipoReceita);
}

class _EditTipoReceitaState extends State<EditTipoReceita> {
    final TipoReceita _tipoReceita;
    final TextEditingController _nomeController = TextEditingController();
    final TextEditingController _descricaoController = TextEditingController();

    _EditTipoReceitaState(this._tipoReceita);

  Widget build(BuildContext context) {
      _nomeController.text = _tipoReceita.nome;
      _descricaoController.text = _tipoReceita.descricao;
      return
        Scaffold(
          appBar: AppBar(
            title: const Text('Editando Tipo de Receita'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      labelStyle: TextStyle(fontSize: 24),
                    ),
                  ),
                ),Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _descricaoController,
                        maxLines: 8,
                        decoration: const InputDecoration(
                            hintText: "Descrição"
                        ),
                      ),
                    )
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.check),
            onPressed: () {
              final newTipoReceita = TipoReceita(
                  id: _tipoReceita.id,
                  nome: _nomeController.text,
                  descricao: _descricaoController.text
              );
              if(newTipoReceita.valido()){
                TipoReceitaContoller.update(newTipoReceita).then((value) => Navigator.pop(context));
              }else{
                showDialog(
                    context: context,
                    builder:
                        (context) => ErrorDialog(
                        bodyText: 'Preencha os campos corretamente!'
                    )
                );
              }
            },
          ),
        );
  }
}