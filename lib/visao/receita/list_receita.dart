import 'package:flutter/material.dart';
import 'package:login_screen/controle/receita_controller.dart';
import 'package:login_screen/modelo/beans/receita.dart';
import 'package:login_screen/visao/receita/cad_receita.dart';
import 'package:login_screen/visao/widgets/activity_indicator.dart';
import 'package:login_screen/visao/widgets/delete_edit_dialog_receita.dart';
import 'package:login_screen/visao/widgets/item_list_place_holder.dart';

class ListReceita extends StatefulWidget {

  @override
  State<ListReceita> createState() => _ListReceitaState();
}

class _ListReceitaState extends State<ListReceita> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas'),
      ),
      body: FutureBuilder(
        initialData: const [],
        future: ReceitaContoller.findAll(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.done:
              var receitas = [];
              if (snapshot.data != null){
                receitas = snapshot.data as List<Receita>;
              }
              if(receitas.isEmpty){
                return const ItemListPlaceHolder();
              }
              return ListView.builder(
                  itemCount: receitas.length,
                  itemBuilder: (context, index){
                    return ItemReceita(receitas[index], context, generateOnEnd());
                  }
              );
            default:
              return ActivityIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
            .push(
              MaterialPageRoute(builder: (context) => CadReceita()
            )
          ).then((value) => setState(() {}));
        },
      ),
    );
  }

  generateOnEnd(){
    return () => setState((){});
  }
}

class ItemReceita extends StatelessWidget{

  final Receita _receita;
  final _context;
  final _onEnd;

  ItemReceita(this._receita, this._context, this._onEnd);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Material(
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DeleteEditDialogReceita(_receita, _onEnd)
              );
            },
            child: ListTile(
              leading: const Icon(Icons.money_off),
              title: Text(_receita.dataHora),
              subtitle: Text('R\$${_receita.valor}'),
            ),
          ),
        )
    );
  }
}
