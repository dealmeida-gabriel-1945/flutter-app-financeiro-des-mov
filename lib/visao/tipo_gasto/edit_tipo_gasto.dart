
import 'package:flutter/material.dart';
import 'package:login_screen/controle/tipo_gasto_controller.dart';
import 'package:login_screen/modelo/beans/tipo_gasto.dart';
import 'package:login_screen/visao/widgets/error_dialog.dart';

class EditTipoGasto extends StatefulWidget {

  final TipoGasto _tipoGasto;

  EditTipoGasto(this._tipoGasto);

  @override
  _EditTipoGastoState createState() => _EditTipoGastoState(_tipoGasto);
}

class _EditTipoGastoState extends State<EditTipoGasto> {

  final TipoGasto _tipoGasto;
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  _EditTipoGastoState(this._tipoGasto);

  Widget build(BuildContext context) {
    _nomeController.text = _tipoGasto.nome;
    _descricaoController.text = _tipoGasto.descricao;
    return 
        Scaffold(
          appBar: AppBar(
            title: const Text('Editando Tipo de Gasto'),
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
              final newTipoGasto = TipoGasto(
                  id: _tipoGasto.id,
                  nome: _nomeController.text,
                  descricao: _descricaoController.text
              );

              if(newTipoGasto.valido()){
                TipoGastoContoller.update(newTipoGasto).then((value) => Navigator.pop(context));
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