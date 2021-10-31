
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_screen/controle/tipo_receita_controller.dart';
import 'package:login_screen/modelo/beans/tipo_receita.dart';

class CadTipoReceita extends StatefulWidget {

  @override
  _CadTipoReceitaState createState() => _CadTipoReceitaState();
}

class _CadTipoReceitaState extends State<CadTipoReceita> {
    final TextEditingController _nomeController = TextEditingController();
    final TextEditingController _descricaoController = TextEditingController();

    Widget build(BuildContext context) {
      return
        Scaffold(
          appBar: AppBar(
            title: const Text('Tipo de Receita'),
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
            child: const Icon(Icons.add),
            onPressed: () {
              TipoReceitaContoller.save(TipoReceita(
                  nome: _nomeController.text,
                  descricao: _descricaoController.text
              )).then((value) => Navigator.pop(context));
            },
          ),
        );
  }
}