import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/models/driver.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';
import 'package:ruta_al_sur_v2/widgets/date_and_state_form_field.dart';
import 'package:ruta_al_sur_v2/widgets/is_enabled_banner.dart';

class DriverDetailScreen extends StatelessWidget {
  final Driver driver;
  const DriverDetailScreen(this.driver, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isEnabled = driver.isEnabled;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle Conductor')),
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                IsEnabledBanner(isEnabled: isEnabled, width: width),
                fullName(),
                identification(),
                company(),
                licenseNumber(),
                licenseExpiration(),
                category(),
                medicalTestExpiration(),
                driverTestExpiration(),
                state(),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget fullName() {
    return TextFormField(
        initialValue: '${driver.name} ${driver.lastName}',
        enabled: false,
        decoration: Utils.inputDecoration('Nombre Completo'));
  }

  Widget identification() {
    return TextFormField(
        initialValue: driver.identification,
        enabled: false,
        decoration: Utils.inputDecoration('Identificación'));
  }

  Widget company() {
    return TextFormField(
        initialValue: driver.company,
        enabled: false,
        decoration: Utils.inputDecoration('Empresa'));
  }

  Widget licenseNumber() {
    return TextFormField(
        initialValue: driver.licenseNumber,
        enabled: false,
        decoration: Utils.inputDecoration('Número de licencia'));
  }

  Widget licenseExpiration() {
    return DateAndStateFormField(
      dateTime: driver.licenseExpiration ?? '',
      state: driver.licenseState,
      labelText: 'Fecha de expiración licencia',
    );
  }

  Widget category() {
    return TextFormField(
        initialValue: driver.category,
        enabled: false,
        decoration: Utils.inputDecoration('Categoría'));
  }

  Widget medicalTestExpiration() {
    return DateAndStateFormField(
      dateTime: driver.medicalTestExpiration ?? '',
      state: driver.medicalTestState,
      labelText: 'Fecha de expiración examen médico ocupacional',
    );
  }

  Widget driverTestExpiration() {
    return DateAndStateFormField(
      dateTime: driver.driverTestExpiration ?? '',
      labelText: 'Fecha de expiración examen de manejo a la defensiva',
    );
  }

  Widget state() {
    return TextFormField(
        initialValue: driver.state,
        enabled: false,
        decoration: Utils.inputDecoration('Estado'));
  }
}
