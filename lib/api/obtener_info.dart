import 'dart:convert';

import 'package:tienda_virtual/modelo/modelo.dart';
import 'package:http/http.dart' as http;

Future<Modelo> obtenerData() async {
  final response = await http.get(Uri.parse(
      'https://randomapi.com/api/6de6abfedb24f889e0b5f675edc50deb?fmt=raw&sole'));

  if (response.statusCode == 200) {
    final dynamic jsonData = jsonDecode(response.body);
    if (jsonData is List && jsonData.isNotEmpty) {
      return Modelo.fromJson(jsonData.first);
    } else {
      throw Exception('Sin respuesta');
    }
  } else {
    throw Exception('Fallo al obtener data');
  }
}
