import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_screen/visao/gasto/cad_gasto.dart';
import 'package:login_screen/visao/principal.dart';
import 'package:login_screen/visao/receita/list_receita.dart';
import 'package:login_screen/visao/relatorios.dart';
import 'package:login_screen/visao/tipo_gasto/list_tipo_gasto.dart';
import 'package:login_screen/visao/tipo_receita/list_tipo_receita.dart';

//indice de seleção da tela
int _selectedIndex = 0;

//vetor de telas a serem utilizadas
List<Widget> _stOptions = <Widget>[
  Principal(),
  ListReceita(),
  CadGasto(),
  ListTipoReceita(),
  ListTipoGasto(),
  Relatorios(),
];

class Navegar extends StatefulWidget {
  int _opcao;

  //contrutor passando o indice da tela selecionada
  Navegar(this._opcao);

  @override
  _NavegarState createState() => _NavegarState(this._opcao);
}

class _NavegarState extends State<Navegar> {

  //construtor
  _NavegarState(this._opcao);
  int _opcao;

  @override
  void initState() {
    _selectedIndex = _opcao;
  }


  Widget build(BuildContext context) {
    return  Scaffold(

      //corpo da aplicação, aqui são setadas as telas
      body: _stOptions.elementAt(_selectedIndex),

      //botões do BN
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Principal'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text('Receitas'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            title: Text('Gastos'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text('Tipos Receitas'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            title: Text('Tipo Gastos'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Relatorios'),
          ),
        ],

        unselectedItemColor: Colors.grey,

        currentIndex: _selectedIndex,

        selectedItemColor: Colors.orange,
        //greenAccent,
        onTap:
        _onItemTapped, //chama o métdodo onItemTapped ao clicar no botao do BTNNavigation
      ),
    );
  }

  @override
  void _onItemTapped(int  index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}