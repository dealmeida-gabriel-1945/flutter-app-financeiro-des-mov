import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_screen/visao/gasto/list_gasto.dart';
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
  ListGasto(),
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

      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Fluxo App"),
              accountEmail: Text("Aplicativo de apoio financeiro"),
              decoration: BoxDecoration(
                color: Color(0xFF00ad9e),
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blueGrey]),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://www.ifmg.edu.br/portal/imagens/logovertical.jpg'),
                backgroundColor: Colors.transparent,
              ),
              arrowColor: Colors.teal,
            ),
            ListTile(
              enabled: _selectedIndex != 0,
              title: const Text('Principal'),
              leading: const Icon(Icons.home),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              enabled: _selectedIndex != 1,
              title: const Text('Receitas'),
              leading: const Icon(Icons.attach_money),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              enabled: _selectedIndex != 2,
              title: const Text('Gastos'),
              leading: const Icon(Icons.money_off),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              enabled: _selectedIndex != 3,
              title: const Text('Tipos de Receita'),
              leading: const Icon(Icons.attach_money),
              onTap: () => _onItemTapped(3),
            ),
            ListTile(
              enabled: _selectedIndex != 4,
              title: const Text('Tipos de Gasto'),
              leading: const Icon(Icons.money_off),
              onTap: () => _onItemTapped(4),
            ),
            ListTile(
              enabled: _selectedIndex != 5,
              title: const Text('Relatórios'),
              leading: const Icon(Icons.list),
              onTap: () => _onItemTapped(5),
            ),
          ],
        )
      ),
    );
  }

  @override
  void _onItemTapped(int index) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Navegar(index)
        )
    );
  }
}