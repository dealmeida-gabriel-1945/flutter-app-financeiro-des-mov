import 'package:flutter/material.dart';
import 'package:login_screen/modelo/beans/tipo_gasto.dart';
import 'package:login_screen/visao/tipo_gasto/cad_tipo_gasto.dart';
import 'package:login_screen/visao/widgets/delete_edit_dialog_tipo_gasto.dart';

class ListTipoGasto extends StatefulWidget {

  final List<TipoGasto> _tipoDeGasto = [//TODO: mudar para pegar dados do banco
    TipoGasto(id: 1, nome: 'TESTE 01', descricao: 'TESTE 01'),
    TipoGasto(id: 2, nome: 'TESTE 02', descricao: 'TESTE 02'),
    TipoGasto(id: 3, nome: 'TESTE 03', descricao: 'TESTE 03'),
    TipoGasto(id: 4, nome: 'TESTE 04', descricao: 'TESTE 04'),
  ];

  @override
  State<ListTipoGasto> createState() => _ListTipoGastoState();
}

class _ListTipoGastoState extends State<ListTipoGasto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tipos de gasto'),
      ),
      body: ListView.builder(
        itemCount: widget._tipoDeGasto.length,
        itemBuilder: (context, index){
          return ItemTipoGasto(widget._tipoDeGasto[index], context);
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
            .push(
              MaterialPageRoute(builder: (context) => CadTipoGasto()
            )
          ).then((value) => debugPrint('Buscar tipos de gasto do banco')); //TODO
        },
      ),
    );
  }
}

class ItemTipoGasto extends StatelessWidget{

  final TipoGasto _tipoReceita;
  final _context;

  ItemTipoGasto(this._tipoReceita, this._context);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Material(
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DeleteEditDialogTipoGasto(_tipoReceita)
              );
            },
            child: ListTile(
              leading: const Icon(Icons.money_off),
              title: Text(_tipoReceita.nome),
              subtitle: Text(_tipoReceita.descricao),
            ),
          ),
        )
    );
  }
}
