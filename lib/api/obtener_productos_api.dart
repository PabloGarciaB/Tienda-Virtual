import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List> obtenerProducto() async {
  final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products'));

  final data = jsonDecode(response.body);

  return data;
}
