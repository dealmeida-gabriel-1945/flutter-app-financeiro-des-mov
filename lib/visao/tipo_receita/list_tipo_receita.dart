import 'package:flutter/material.dart';
import 'package:login_screen/modelo/beans/tipo_receita.dart';
import 'package:login_screen/visao/tipo_receita/cad_tipo_receita.dart';
import 'package:login_screen/visao/widgets/delete_edit_dialog_tipo_receita.dart';

class ListTipoReceita extends StatefulWidget {

  final List<TipoReceita> _transferencias = [
    TipoReceita(id: 1, nome: 'TESTE 01', descricao: 'TESTE 01'),
    TipoReceita(id: 2, nome: 'TESTE 02', descricao: 'TESTE 02'),
    TipoReceita(id: 3, nome: 'TESTE 03', descricao: 'TESTE 03'),
    TipoReceita(id: 4, nome: 'TESTE 04', descricao: 'TESTE 04'),
  ];

  @override
  State<ListTipoReceita> createState() => _ListTipoReceitaState();
}

class _ListTipoReceitaState extends State<ListTipoReceita> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tipos de receita'),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, index){
          return ItemTipoReceita(widget._transferencias[index], context);
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
            .push(
              MaterialPageRoute(builder: (context) => CadTipoReceita()
            )
          ).then((value) => debugPrint('Buscar tipos de receita do banco')); //TODO
        },
      ),
    );
  }
}

class ItemTipoReceita extends StatelessWidget{

  final TipoReceita _tipoReceita;
  final _context;

  ItemTipoReceita(this._tipoReceita, this._context);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Material(
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DeleteEditDialogTipoReceita(_tipoReceita)
              );
            },
            child: ListTile(
              leading: const Icon(Icons.monetization_on),
              title: Text(_tipoReceita.nome),
              subtitle: Text(_tipoReceita.descricao),
            ),
          ),
        )
    );
  }
}
