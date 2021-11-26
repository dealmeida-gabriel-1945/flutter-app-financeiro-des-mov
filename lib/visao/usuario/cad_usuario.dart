
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_screen/controle/gasto_controller.dart';
import 'package:login_screen/controle/receita_controller.dart';
import 'package:login_screen/controle/tipo_gasto_controller.dart';
import 'package:login_screen/controle/tipo_receita_controller.dart';
import 'package:login_screen/controle/usuario_controller.dart';
import 'package:login_screen/modelo/beans/tipo_receita.dart';
import 'package:login_screen/modelo/beans/usuario.dart';
import 'package:login_screen/visao/widgets/error_dialog.dart';

class CadUsuario extends StatefulWidget {

  @override
  _CadUsuarioState createState() => _CadUsuarioState();
}

class _CadUsuarioState extends State<CadUsuario> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  var _dataValue = DateTime.now();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  var _dataController;
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  Widget build(BuildContext context) {
    _dataController = TextEditingController(
        text: formataData()
    );

    return
      Scaffold(
        appBar: AppBar(
          title: const Text('Tipo de Usuário'),
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _sobrenomeController,
                  decoration: const InputDecoration(
                    labelText: 'Sobrenome',
                    labelStyle: TextStyle(fontSize: 24),
                  ),
                ),
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
                          labelText: 'Data de Nascimento',
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
                  controller: _cpfController,
                  decoration: const InputDecoration(
                    labelText: 'CPF',
                    labelStyle: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: _senhaController,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      labelStyle: TextStyle(fontSize: 24),
                    ),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.check),
          onPressed: () {
            final newUsuario = Usuario(
                nome: _nomeController.text,
                sobrenome: _sobrenomeController.text,
                cpf: _cpfController.text,
                dataNascimento: DateTime(
                  _dataValue.year, _dataValue.month, _dataValue.day
                ),
                senha: _senhaController.text
            );
            if(newUsuario.valido()){
              salvaUsuario(newUsuario);
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

  showSeletorDeData(){
    showDatePicker(
        context: context,
        initialDate: _dataValue,
        firstDate: DateTime(0),
        lastDate: DateTime(5000)
    ).then((newDate) => setState((){
      if(newDate != null){
        _dataValue = newDate;
      }
    }));
  }

  void salvaUsuario(Usuario newUsuario) {
    UsuarioContoller.save(newUsuario).then((value) =>
        deletaTabelasSemFK()
    );
  }

  deletaTabelasSemFK() {
    GastoContoller.findAll().then((gastos) {
      for (var gasto in gastos) { 
        GastoContoller.delete(gasto.id);
      }
      ReceitaContoller.findAll().then((receitas) {
        for (var receita in receitas){
          ReceitaContoller.delete(receita.id);
        }
        deletaTipos();
      });
    });
  }

  deletaTipos() {
    TipoGastoContoller.findAll().then((tipoGastos) {
      for (var tipo in tipoGastos) {
        TipoGastoContoller.delete(tipo.id);
      }
      TipoReceitaContoller.findAll().then((tipoReceitas) {
        for (var tipo in tipoReceitas){
            TipoReceitaContoller.delete(tipo.id);
        }
        Navigator.pop(context);
      });
    });
  }
  
  formataData(){
    return _dateFormat.format(_dataValue);
  }
}