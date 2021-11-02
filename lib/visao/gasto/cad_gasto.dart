import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:login_screen/controle/gasto_controller.dart';
import 'package:login_screen/controle/tipo_gasto_controller.dart';
import 'package:login_screen/modelo/beans/gasto.dart';
import 'package:login_screen/modelo/beans/tipo_gasto.dart';
import 'package:login_screen/visao/widgets/activity_indicator.dart';
import 'package:login_screen/visao/widgets/error_dialog.dart';

class CadGasto extends StatefulWidget {

  @override
  _CadGastoState createState() => _CadGastoState();
}

class _CadGastoState extends State<CadGasto> {
  final TextEditingController _observacoesController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  var _dataValue = DateTime.now();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  var _dataController;
  var _horaValue = TimeOfDay.now();
  var _tiposDeGasto = [];
  var _tipoDeGastoController;

  Widget build(BuildContext context) {
    _dataController = TextEditingController(
        text: formataData()
    );

    return FutureBuilder(
      future: TipoGastoContoller.findAll(),
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.done:
            if(snapshot.data != null){
              _tiposDeGasto = snapshot.data as List<TipoGasto>;
            }
            return renderForm();
          default:
            return ActivityIndicator(false, 'Gasto');
        }
      },
    );
  }

  renderFloatingActionButton(){
    if(_tiposDeGasto.isEmpty){
      return FloatingActionButton(
        child: const Icon(Icons.close),
        backgroundColor: Colors.red,
        onPressed: () {
          showDialog(
              context: context,
              builder:
                  (context) => ErrorDialog(
                  bodyText: 'Não é possível cadastrar um gasto quando não há tipos de gasto cadastrados'
              )
          );
        },
      );
    }
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        final valor = double.tryParse(_valorController.text) ?? 0;
        final dataHora = DateTime(
            _dataValue.year, _dataValue.month, _dataValue.day,
            _horaValue.hour, _horaValue.minute);
        final newGasto = Gasto(
            0, _observacoesController.text, dataHora, valor,
            TipoGasto(id: _tipoDeGastoController)
        );
        if(newGasto.valido()) {
          GastoContoller.save(newGasto)
              .then((value) => Navigator.pop(context));
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
    );
  }


  renderForm(){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gasto'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _observacoesController,
                    maxLines: 8,
                    decoration: const InputDecoration(
                        hintText: "Observações"
                    ),
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TextField(
                      enabled: false,
                      controller: _dataController,
                      decoration: const InputDecoration(
                        labelText: 'Data e hora',
                        labelStyle: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      child: const Icon(Icons.calendar_today),
                      onPressed: () => showSeletorDeData(),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _valorController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Valor',
                  labelStyle: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Tipo do gasto:',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: DropdownButton(
                        value: _tipoDeGastoController,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        onChanged: (newTipo) {
                          setState((){
                            _tipoDeGastoController = newTipo;
                          });
                        },
                        items: generateDropdownItens(),
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
      floatingActionButton: renderFloatingActionButton(),
    );
  }

  generateDropdownItens(){
    return _tiposDeGasto
        .map((tipo) => DropdownMenuItem(
      child: Text(tipo.nome),
      value: tipo.id,
    )).toList();
  }

  showSeletorDeData(){
    showDatePicker(
        context: context,
        initialDate: _dataValue,
        firstDate: DateTime(0),
        lastDate: DateTime(5000)
    ).then((newDate) => setState((){
      if(newDate != null){
        _dataValue = newDate;
        showSeletorDeHora();
      }
    }));
  }

  showSeletorDeHora(){
    showTimePicker(
        context: context, initialTime: _horaValue
    ).then((newTime) => setState((){
      if(newTime != null){
        _horaValue = newTime;
      }
    }));
  }

  formataData(){
    return '${_dateFormat.format(_dataValue)} ${formataTime(_horaValue.hour)}:${formataTime(_horaValue.minute)}';
  }

  formataTime(time){
    if(time < 10){
      return '0$time';
    }
    return time;
  }
}