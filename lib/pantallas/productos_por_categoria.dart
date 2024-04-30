import 'package:flutter/material.dart';
import 'package:tienda_virtual/api/obtener_categoria_api.dart';
import 'package:tienda_virtual/modelo/carrito.dart';
import 'package:tienda_virtual/pantallas/ver_carrito.dart';

class ProductosPorCategoria extends StatefulWidget {
  final String categoria;
  final Carrito carrito;
  const ProductosPorCategoria(
      {super.key, required this.categoria, required this.carrito});

  @override
  State<ProductosPorCategoria> createState() => _ProductosPorCategoriaState();
}

class _ProductosPorCategoriaState extends State<ProductosPorCategoria> {
  //final Carrito carrito = Carrito();

  void agregarACarrito(String nombreProducto, double precioProducto) {
    setState(() {
      widget.carrito.items
          .add(CarritoItem(nombre: nombreProducto, precio: precioProducto));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Productos de la categoria ${widget.categoria}',
          maxLines: 2,
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: obtenerProductoCategoria(widget.categoria),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Sin data'),
            );
          }
          final productos = snapshot.data ?? [];

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final producto = productos[index];
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Card.outlined(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                        producto['image'],
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(child: Text(producto['title'])),
                      const Padding(padding: EdgeInsets.all(1)),
                      Text(
                        '\$ ${producto['price']}',
                        maxLines: 1,
                      ),
                      IconButton(
                        onPressed: () {
                          agregarACarrito(
                              producto['title'], producto['price'].toDouble());
                        },
                        icon: const Icon(Icons.add_circle),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerCarrito(carrito: widget.carrito),
            ),
          );
        },
        label: Text('Ver Carrito (${widget.carrito.items.length})'),
        icon: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
