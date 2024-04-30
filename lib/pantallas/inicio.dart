import 'package:flutter/material.dart';
import 'package:tienda_virtual/pantallas/side_bar.dart';

import '../api/obtener_productos_api.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Inicio',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: const SideBar(),
      body: FutureBuilder<List>(
        future: obtenerProducto(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return const Center(
              child: Text('Es nulo'),
            );
          }
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Esta vacia la snapshot'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Image.network(
                snapshot.data![index]['image'],
                width: 100,
                height: 100,
              );
            },
          );
        },
      ),
    );
  }
}
