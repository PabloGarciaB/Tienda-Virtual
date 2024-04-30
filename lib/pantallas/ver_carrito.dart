import 'package:flutter/material.dart';
import 'package:tienda_virtual/api/obtener_categoria_api.dart';

import '../modelo/carrito.dart';

class VerCarrito extends StatefulWidget {
  final Carrito carrito;

  const VerCarrito({super.key, required this.carrito});

  @override
  State<VerCarrito> createState() => _VerCarritoState();
}

class _VerCarritoState extends State<VerCarrito> {
  bool productoGratsiAgregado = false;

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
      bottomNavigationBar: BottomAppBar(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            Text('\$ ${widget.carrito.precioNeto}'),
            if (widget.carrito.precioNeto >= 800 &&
                !productoGratsiAgregado) //Observacion
              ElevatedButton(
                onPressed: () {
                  mostrarProductosGratis(context);
                },
                child: const Text('Agregar producto gratis'),
              ),
            ElevatedButton(
              onPressed: () {
                finalizarCompra(context);
              },
              child: const Text('Finalizar compra'),
            ),
          ],
        ),
      ),
    );
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
            title: Text('Productos gratis en $categoria'),
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
                          title: Text(producto['title']),
                          subtitle: Text('\$ ${producto['price']}'),
                          onTap: () {
                            final nombreProducto = producto['title'];
                            final precioProducto = producto['price'].toDouble();
                            Navigator.pop(context);
                            agregarACarrito(
                                context, nombreProducto, precioProducto);
                            setState(() {
                              productoGratsiAgregado = true;
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
    String resumen = resumenCompra();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Resumen de compra'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      resumen,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Regresar al inicio'))
            ],
          );
        });
  }

  String resumenCompra() {
    String resumen = '';

    for (var item in widget.carrito.items) {
      resumen += '${item.nombre}: \$${item.precio}\n';
    }

    resumen += 'Total: \$${widget.carrito.precioNeto}\n';

    return resumen;
  }
}
