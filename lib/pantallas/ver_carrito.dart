import 'package:flutter/material.dart';
import 'package:tienda_virtual/api/obtener_categoria_api.dart';
import 'package:tienda_virtual/pantallas/resumen_compra.dart';

import '../modelo/carrito.dart';

class VerCarrito extends StatefulWidget {
  final Carrito carrito;

  const VerCarrito({super.key, required this.carrito});

  @override
  State<VerCarrito> createState() => _VerCarritoState();
}

class _VerCarritoState extends State<VerCarrito> {
  bool productoGratisAgregado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Carrito'),
        ),
        body: ListView.builder(
          itemCount: widget.carrito.items.length,
          itemBuilder: (context, index) {
            final item = widget.carrito.items[index];
            return ListTile(
              title: Text(item.nombre),
              trailing: Text('\$ ${item.precio}'),
            );
          },
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('\$ ${widget.carrito.precioNeto}'),
              Visibility(
                visible:
                    widget.carrito.precioNeto >= 800 && !productoGratisAgregado,
                child: Column(
                  children: [
                    const Text(
                      'Puedes llevarte un articulo de regalo!',
                      style:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    ), //Observacion
                    ElevatedButton(
                      onPressed: () {
                        mostrarProductosGratis(context);
                      },
                      child: const Text('Agregar producto gratis'),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  finalizarCompra(context);
                },
                child: const Text('Finalizar compra'),
              ),
            ],
          ),
        ));
  }

  void mostrarProductosGratis(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Selecciona una categoria para continuar'),
            content: FutureBuilder<List<String>>(
                future: obtenerCategorias(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error en la snapshot ${snapshot.error}'),
                    );
                  }
                  final categorias = snapshot.data ?? [];

                  return SingleChildScrollView(
                    child: Column(
                      children: categorias.map((categoria) {
                        return ListTile(
                          title: Text(categoria),
                          onTap: () {
                            Navigator.pop(context);
                            seleccionarProductoGratis(context, categoria);
                          },
                        );
                      }).toList(),
                    ),
                  );
                }),
          );
        });
  }

  void seleccionarProductoGratis(BuildContext context, String categoria) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
                'Escoja un articulo para agregar a su compra de manera gratuita'),
            content: FutureBuilder<List<Map<String, dynamic>>>(
                future: obtenerProductoCategoria(categoria),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error en la snapshot ${snapshot.error}'),
                    );
                  }
                  final productos = snapshot.data ?? [];

                  return SingleChildScrollView(
                    child: Column(
                      children: productos.map((producto) {
                        return ListTile(
                          title: Card(
                            margin: EdgeInsets.all(4),
                            child: Text(producto['title']),
                          ),
                          onTap: () {
                            final nombreProducto = producto['title'];
                            Navigator.pop(context);
                            agregarACarrito(context, nombreProducto, 0);
                            setState(() {
                              productoGratisAgregado = true;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  );
                }),
          );
        });
  }

  void agregarACarrito(
      BuildContext context, String nombreProducto, double precioProducto) {
    widget.carrito.items.add(CarritoItem(nombre: nombreProducto, precio: 0));
  }

  void finalizarCompra(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ResumenCompra(carrito: widget.carrito);
      },
    ).then((_) {
      setState(() {
        widget.carrito.items.clear();
      });
    });
  }
}
