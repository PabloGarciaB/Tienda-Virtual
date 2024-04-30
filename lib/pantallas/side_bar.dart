import 'package:flutter/material.dart';

import '../modelo/modelo.dart';

class SideBar extends StatefulWidget {
  final Usuario userData;

  const SideBar({super.key, required this.userData});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    final usuario = widget.userData;
    return Drawer(
      child: SingleChildScrollView(
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
                            style: TextStyle(fontSize: 26, color: Colors.white),
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
                          '${usuario.name!.firstname ?? ''} ${usuario.name!.lastname ?? ''}',
                          style: const TextStyle(
                            fontSize: 28,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: Text(usuario.email ?? '???'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_city),
                        title: const Text('Ciudad'),
                        subtitle: Text(usuario.address!.city ?? '???'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_on_outlined),
                        title: const Text('Nombre de calle y numero:'),
                        subtitle: Text(
                            '${usuario.address!.street ?? ''} ${usuario.address!.number ?? ''}'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: const Text('Telefono:'),
                        subtitle: Text(usuario.phone ?? '????'),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
