
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_screen/controle/relatorio_controller.dart';
import 'dart:convert';

import 'package:login_screen/visao/widgets/activity_indicator.dart';

class Relatorios extends StatefulWidget {

  @override
  _RelatoriosState createState() => _RelatoriosState();
}

class _RelatoriosState extends State<Relatorios> {

  var _cotacao = '';

  Widget build(BuildContext context) {

    RelatorioContoller.get_cotacao_dolar().then(
            (response) {
          debugPrint(response.body);
          _cotacao = json.decode(response.body)['USDBRL']['high'];
        }
    );

    return FutureBuilder(
        initialData: const [],
        future: RelatorioContoller.get_cotacao_dolar(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.done:
              var response = snapshot.data as http.Response;
              return generateBody(json.decode(response.body)['USDBRL']['high']);
            default:
              return ActivityIndicator();
          }
        }
    );
  }
  
  Widget generateBody(cotacao){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Relatórios"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Card(
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    '\$1 = R\$$cotacao',
                    style: const TextStyle(
                        fontSize: 20
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}