import 'package:flutter/material.dart';
import 'package:login_screen/controle/tipo_receita_controller.dart';
import 'package:login_screen/modelo/beans/tipo_receita.dart';
import 'package:login_screen/visao/tipo_receita/cad_tipo_receita.dart';
import 'package:login_screen/visao/widgets/activity_indicator.dart';
import 'package:login_screen/visao/widgets/delete_edit_dialog_tipo_receita.dart';
import 'package:login_screen/visao/widgets/item_list_place_holder.dart';

class ListTipoReceita extends StatefulWidget {

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
      body: FutureBuilder(
        initialData: const [],
        future: TipoReceitaContoller.findAll(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done:
              var tipos = [];
              if (snapshot.data != null){
                tipos = snapshot.data as List<TipoReceita>;
              }
              if(tipos.isEmpty){
                return const ItemListPlaceHolder();
              }
              return ListView.builder(
                  itemCount: tipos.length,
                  itemBuilder: (context, index){
                    return ItemTipoReceita(
                      tipos[index], context, generateOnEnd()
                    );
                  }
              );
            default:
              return const ActivityIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
            .push(
              MaterialPageRoute(builder: (context) => CadTipoReceita()
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

class ItemTipoReceita extends StatelessWidget{

  final TipoReceita _tipoReceita;
  final _context;
  final _onEnd;

  ItemTipoReceita(this._tipoReceita, this._context, this._onEnd);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Material(
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DeleteEditDialogTipoReceita(_tipoReceita, _onEnd)
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

