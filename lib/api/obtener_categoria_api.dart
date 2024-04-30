import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<String>> obtenerCategorias() async {
  final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));

  final data = jsonDecode(response.body);

  if (data is List) {
    return List<String>.from(data);
  } else {
    throw Exception('No se recupero las categorias');
  }
}

Future<List<Map<String, dynamic>>> obtenerProductoCategoria(
    String categoria) async {
  final response = await http
      .get(Uri.parse('https://fakestoreapi.com/products/category/$categoria'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Fallo al obtener los productos de la categoria');
  }
}

Future<List<Map<String, dynamic>>> obtenerProductoRegalo(
    BuildContext context, String categoria) async {
  final response = await http
      .get(Uri.parse('https://fakestoreapi.com/products/category/$categoria'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    final productosBaratos = data.where((producto) {
      final double precio = double.tryParse(producto['price'].toString()) ?? 0;
      return precio < 100;
    }).toList();
    return productosBaratos.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Fallo al obtener los productos de la categoria');
  }
}
