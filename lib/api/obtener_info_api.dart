import 'dart:convert';

import 'package:tienda_virtual/modelo/modelo.dart';
import 'package:http/http.dart' as http;

Future<Usuario> obtenerData() async {
  final response =
      await http.get(Uri.parse('https://fakestoreapi.com/users/1'));

  if (response.statusCode == 200) {
    final dynamic jsonData = jsonDecode(response.body);
    if (jsonData != null) {
      return Usuario.fromJson(jsonData);
    } else {
      throw Exception('Sin respuesta');
    }
  } else {
    throw Exception('Fallo al obtener data');
  }
}
