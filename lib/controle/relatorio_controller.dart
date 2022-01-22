
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class RelatorioContoller {

  static Future<http.Response> get_cotacao_dolar() {
    debugPrint('Buscando cotação');
    return http.get(Uri.parse('http://economia.awesomeapi.com.br/json/last/USD-BRL'));
  }
}