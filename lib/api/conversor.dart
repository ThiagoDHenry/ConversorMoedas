import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://economia.awesomeapi.com.br/json/last/USD-BRL,EUR-BRL";

Future<Map> getData() async {
  final Uri uri = Uri.parse(request); // Converte a String para Uri
  http.Response response = await http.get(uri);
  return json.decode(response.body); // Retorna os dados decodificados
}
