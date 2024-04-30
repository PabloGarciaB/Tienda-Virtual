class CarritoItem {
  final String nombre;
  final double precio;

  CarritoItem({
    required this.nombre,
    required this.precio,
  });
}

class Carrito {
  final List<CarritoItem> items;

  Carrito({List<CarritoItem>? itemsIniciales}) : items = itemsIniciales ?? [];

  double get precioNeto => items.fold(0, (total, item) => total + item.precio);
}
