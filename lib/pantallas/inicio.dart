import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tienda_virtual/modelo/modelo.dart';
import 'package:tienda_virtual/pantallas/side_bar.dart';

import '../api/obtener_categoria_api.dart';

class Inicio extends StatelessWidget {
  final Usuario userData;

  const Inicio({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: obtenerCategorias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error al intentar obtener la informacion'),
            );
          }
          final categorias_data = snapshot.data ?? [];

          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  'Inicio',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.deepPurple,
              ),
              drawer: SideBar(userData: userData),
              body: GridView.builder(
                itemCount: categorias_data.length,
                itemBuilder: (context, index) {
                  final categoria = categorias_data[index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Card.outlined(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(
                            categoria,
                            style: const TextStyle(fontSize: 28),
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(padding: EdgeInsets.all(1)),
                              Text(
                                '',
                                maxLines: 1,
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.forward))
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
              ));
        });
  }
}
