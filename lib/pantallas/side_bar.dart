import 'package:flutter/material.dart';
import 'package:tienda_virtual/api/obtener_info_api.dart';

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
      child: FutureBuilder<Usuario>(
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
                                '${data.name!.firstname ?? ''} ${data.name!.lastname ?? ''}',
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
                              title: Text('Ciudad'),
                              subtitle: Text(data.address!.city ?? '???'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.location_on_outlined),
                              title: const Text('Nombre de calle y numero:'),
                              subtitle: Text(
                                  '${data.address!.street ?? ''} ${data.address!.number ?? ''}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.phone),
                              title: const Text('Telefono:'),
                              subtitle: Text(data.phone ?? '????'),
                            ),
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
