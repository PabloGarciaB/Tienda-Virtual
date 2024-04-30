import 'package:flutter/material.dart';
import 'package:tienda_virtual/modelo/carrito.dart';

class ResumenCompra extends StatelessWidget {
  final Carrito carrito;
  const ResumenCompra({super.key, required this.carrito});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              const Text(
                'Resumen de compra',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Gracias por tu compra',
                style: TextStyle(fontSize: 18.0),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: carrito.items.length,
                itemBuilder: (context, index) {
                  final item = carrito.items[index];
                  return ListTile(
                    title: Text(item.nombre),
                    subtitle: Text('\$ ${item.precio}'),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Total: \$${carrito.precioNeto}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Regresar'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
