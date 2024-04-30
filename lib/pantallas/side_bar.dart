import 'package:flutter/material.dart';
import 'package:tienda_virtual/api/obtener_info.dart';

import '../modelo/modelo.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<Modelo>(
        future: obtenerData(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            debugPrint('Error: ${snapshot.error}');
            return const Center(
              child: Text('No se pudo recuperar la informacion'),
            );
          } else {
            final data = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        color: Colors.deepPurple,
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Perfil',
                                  style: TextStyle(
                                      fontSize: 26, color: Colors.white),
                                  textAlign: TextAlign.center),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(24),
                        child: Wrap(
                          runSpacing: 24,
                          children: [
                            ListTile(
                              title: Text(
                                '${data.first ?? ''} ${data.last ?? ''}',
                                style: const TextStyle(
                                  fontSize: 28,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.email),
                              title: Text(data.email ?? '???'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.location_city),
                              title: Text(data.address ?? '???'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.date_range_outlined),
                              title: const Text('Usuario desde:'),
                              subtitle: Text(data.created ?? ' ????'),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
