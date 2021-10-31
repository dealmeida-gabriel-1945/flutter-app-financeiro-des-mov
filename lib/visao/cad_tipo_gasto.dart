
import 'package:flutter/material.dart';
import 'package:login_screen/modelo/beans/tipo_gasto.dart';

class CadTipoGasto extends StatefulWidget {

  @override
  _CadTipoGastoState createState() => _CadTipoGastoState();
}

class _CadTipoGastoState extends State<CadTipoGasto> {

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  Widget build(BuildContext context) {
    return 
        Scaffold(
          appBar: AppBar(
            title: const Text('Tipo de Gasto'),
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
              var tipoGasto = TipoGasto(
                  nome: _nomeController.text,
                  descricao: _descricaoController.text
              );
              debugPrint('pressionado');
              debugPrint('$tipoGasto');
            },
          ),
        );
  }
}