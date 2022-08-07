import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/screens/home_screen.dart';
import 'package:ruta_al_sur_v2/search/search_drivers.dart';
import 'package:ruta_al_sur_v2/search/search_vehicles.dart';
import 'package:ruta_al_sur_v2/search/search_workers.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Image.asset('assets/logo-ruta-al-sur.jpeg'),
        ),
        ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: ((context) => HomeScreen())))),
        ListTile(
            leading: const Icon(Icons.supervised_user_circle),
            title: const Text('Conductores'),
            onTap: () =>
                showSearch(context: context, delegate: SearchDrivers())),
        ListTile(
            leading: const Icon(Icons.drive_eta_rounded),
            title: const Text('Vehículos'),
            onTap: () =>
                showSearch(context: context, delegate: SearchVehicles())),
        ListTile(
            leading: const Icon(Icons.work),
            title: const Text('Trabajadores'),
            onTap: () =>
                showSearch(context: context, delegate: SearchWorkers())),
        const Divider(),
        ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar Sesión'),
            onTap: () {
              FirebaseAuth.instance.signOut();
            })
      ]),
    );
  }
}
