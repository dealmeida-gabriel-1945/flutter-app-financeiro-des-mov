import 'package:flutter/material.dart';
import 'package:login_screen/controle/tipo_gasto_controller.dart';
import 'package:login_screen/modelo/beans/tipo_gasto.dart';
import 'package:login_screen/visao/tipo_gasto/cad_tipo_gasto.dart';
import 'package:login_screen/visao/widgets/activity_indicator.dart';
import 'package:login_screen/visao/widgets/delete_edit_dialog_tipo_gasto.dart';
import 'package:login_screen/visao/widgets/item_list_place_holder.dart';

class ListTipoGasto extends StatefulWidget {

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
      body: FutureBuilder(
        initialData: const [],
        future: TipoGastoContoller.findAll(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.done:
              var tipos = [];
              if (snapshot.data != null){
                tipos = snapshot.data as List<TipoGasto>;
              }
              if(tipos.isEmpty){
                return const ItemListPlaceHolder();
              }
              return ListView.builder(
                  itemCount: tipos.length,
                  itemBuilder: (context, index){
                    return ItemTipoGasto(tipos[index], context, generateOnEnd());
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
              MaterialPageRoute(builder: (context) => CadTipoGasto()
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

class ItemTipoGasto extends StatelessWidget{

  final TipoGasto _tipoReceita;
  final _context;
  final _onEnd;

  ItemTipoGasto(this._tipoReceita, this._context, this._onEnd);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Material(
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DeleteEditDialogTipoGasto(_tipoReceita, _onEnd)
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
