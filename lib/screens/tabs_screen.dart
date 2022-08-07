import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/screens/home_screen.dart';
import 'package:ruta_al_sur_v2/search/search_drivers.dart';
import 'package:ruta_al_sur_v2/search/search_vehicles.dart';
import 'package:ruta_al_sur_v2/search/search_workers.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: HomeScreen(),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: BottomNavigationBar(
              currentIndex: 0,
              onTap: (i) {
                if (i == 1) {
                  showSearch(context: context, delegate: SearchDrivers());
                }
                if (i == 2) {
                  showSearch(context: context, delegate: SearchVehicles());
                }
                if (i == 3) {
                  showSearch(context: context, delegate: SearchWorkers());
                }
              },
              items: const [
                BottomNavigationBarItem(
                    backgroundColor: Utils.lightGreen,
                    icon: Icon(Icons.home),
                    label: 'Inicio'),
                BottomNavigationBarItem(
                    backgroundColor: Utils.lightGreen,
                    icon: Icon(Icons.supervised_user_circle),
                    label: 'Conductores'),
                BottomNavigationBarItem(
                    backgroundColor: Utils.lightGreen,
                    icon: Icon(Icons.drive_eta_rounded),
                    label: 'Vehículos'),
                BottomNavigationBarItem(
                    backgroundColor: Utils.lightGreen,
                    icon: Icon(Icons.work),
                    label: 'Trabajadores'),
              ]),
        ));
  }
}
