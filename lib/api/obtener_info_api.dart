import 'dart:convert';

import 'package:tienda_virtual/modelo/modelo.dart';
import 'package:http/http.dart' as http;

Future<Usuario> obtenerData(String username) async {
  final response = await http.get(Uri.parse('https://fakestoreapi.com/users'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonDataList = jsonDecode(response.body);
    final userData = jsonDataList.firstWhere(
      (user) => user['username'] == username,
      orElse: () => null,
    );

    return Usuario.fromJson(userData);
  } else {
    throw Exception('Fallo al obtener data');
  }
}
