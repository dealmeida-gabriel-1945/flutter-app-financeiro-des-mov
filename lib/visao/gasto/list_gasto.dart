import 'package:flutter/material.dart';
import 'package:login_screen/controle/gasto_controller.dart';
import 'package:login_screen/modelo/beans/gasto.dart';
import 'package:login_screen/util/date_util.dart';
import 'package:login_screen/visao/gasto/cad_gasto.dart';
import 'package:login_screen/visao/widgets/activity_indicator.dart';
import 'package:login_screen/visao/widgets/delete_edit_dialog_gasto.dart';
import 'package:login_screen/visao/widgets/item_list_place_holder.dart';

class ListGasto extends StatefulWidget {

  @override
  State<ListGasto> createState() => _ListGastoState();
}

class _ListGastoState extends State<ListGasto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastos'),
      ),
      body: FutureBuilder(
        initialData: const [],
        future: GastoContoller.findAll(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.done:
              var receitas = [];
              if (snapshot.data != null){
                receitas = snapshot.data as List<Gasto>;
              }
              if(receitas.isEmpty){
                return const ItemListPlaceHolder();
              }
              return ListView.builder(
                  itemCount: receitas.length,
                  itemBuilder: (context, index){
                    return ItemGasto(receitas[index], context, generateOnEnd());
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
              MaterialPageRoute(builder: (context) => CadGasto()
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

class ItemGasto extends StatelessWidget{

  final Gasto _gasto;
  final _context;
  final _onEnd;

  ItemGasto(this._gasto, this._context, this._onEnd);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Material(
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DeleteEditDialogGasto(_gasto, _onEnd)
              );
            },
            child: ListTile(
              leading: const Icon(Icons.attach_money),
              title: Text('#${_gasto.id} ${DateUtil.dateToShow(_gasto.dataHora)} (${_gasto.tipo.nome})'),
              subtitle: Text('R\$${_gasto.valor}'),
            ),
          ),
        )
    );
  }
}
