import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/search/search_drivers.dart';
import 'package:ruta_al_sur_v2/search/search_vehicles.dart';
import 'package:ruta_al_sur_v2/search/search_workers.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';
import 'package:ruta_al_sur_v2/widgets/custom_button.dart';
import 'package:ruta_al_sur_v2/widgets/custom_drawer.dart';
import 'package:ruta_al_sur_v2/widgets/worker_banner.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          title: const Text('Inicio'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(children: [
                  WorkerBanner(
                      title: '${user.email}',
                      subtitle: 'Bienvenido a la app ruta al sur',
                      image: 'assets/splash.png'),
                  const SizedBox(height: 20),
                  Text('Consulta de datos',
                      style: Theme.of(context).textTheme.headline4),
                  FadeInLeft(
                    child: CustomButton(
                        icon: Icons.supervised_user_circle,
                        text: 'Conductores',
                        firstColor: Utils.lightGreen,
                        secondColor: Utils.green,
                        onPressed: () => showSearch(
                            context: context, delegate: SearchDrivers())),
                  ),
                  FadeInRight(
                    child: CustomButton(
                        icon: Icons.drive_eta_rounded,
                        text: 'Vehículos',
                        firstColor: Utils.lightGreen,
                        secondColor: Utils.green,
                        onPressed: () => showSearch(
                            context: context, delegate: SearchVehicles())),
                  ),
                  FadeInRight(
                    child: CustomButton(
                        icon: Icons.work,
                        text: 'Trabajadores',
                        firstColor: Utils.lightGreen,
                        secondColor: Utils.green,
                        onPressed: () => showSearch(
                            context: context, delegate: SearchWorkers())),
                  )
                ]))));
  }
}
