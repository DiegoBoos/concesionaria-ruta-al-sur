import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/models/vehicle.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';
import 'package:ruta_al_sur_v2/widgets/date_and_state_form_field.dart';
import 'package:ruta_al_sur_v2/widgets/is_enabled_banner.dart';

class VehicleDetailScreen extends StatelessWidget {
  final Vehicle vehicle;
  const VehicleDetailScreen(this.vehicle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isEnabled = vehicle.isEnabled;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: const Text('Detalle vehículo')),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      IsEnabledBanner(isEnabled: isEnabled, width: width),
                      licensePlate(),
                      propertyCardNumber(),
                      company(),
                      soat(),
                      soatExpiration(),
                      technoReviewNumber(),
                      technoReviewExpiration(),
                      rcePolicy(),
                      rceExpiration(),
                      state(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

  Widget isEnabled(BuildContext context) {
    var buttonColor = vehicle.isEnabled == 'SI'
        ? MaterialStateProperty.all(Utils.isEnabledColor)
        : MaterialStateProperty.all(Utils.isDisabledColor);
    final width = MediaQuery.of(context).size.width;
    return TextButton(
        onPressed: null,
        style: ButtonStyle(
            backgroundColor: buttonColor,
            fixedSize: MaterialStateProperty.all(Size.fromWidth(width))),
        child: Text('Habilitado: ${vehicle.isEnabled}',
            style: const TextStyle(color: Colors.white)));
  }

  Widget licensePlate() {
    return TextFormField(
        initialValue: vehicle.licensePlate,
        enabled: false,
        decoration: Utils.inputDecoration('Placa'));
  }

  Widget propertyCardNumber() {
    return TextFormField(
        initialValue: '${vehicle.propertyCardNumber}',
        enabled: false,
        decoration: Utils.inputDecoration('Tarjeta de propiedad'));
  }

  Widget company() {
    return TextFormField(
        initialValue: vehicle.company,
        enabled: false,
        decoration: Utils.inputDecoration('Empresa'));
  }

  Widget soat() {
    return TextFormField(
        initialValue: '${vehicle.soat}',
        enabled: false,
        decoration: Utils.inputDecoration('SOAT'));
  }

  Widget soatExpiration() {
    return DateAndStateFormField(
      dateTime: vehicle.soatExpiration ?? '',
      state: vehicle.soatState,
      labelText: 'Fecha de expiración SOAT',
    );
  }

  Widget technoReviewNumber() {
    return TextFormField(
        initialValue: '${vehicle.technoReviewNumber}',
        enabled: false,
        decoration: Utils.inputDecoration('Número de revisión tecnomecánica'));
  }

  Widget technoReviewExpiration() {
    return DateAndStateFormField(
      dateTime: vehicle.technoReviewExpiration ?? '',
      state: vehicle.technoState,
      labelText: 'Fecha de expiración tecnomecánica',
    );
  }

  Widget rcePolicy() {
    return TextFormField(
        initialValue: vehicle.rcePolicy,
        enabled: false,
        decoration: Utils.inputDecoration('Póliza Rce'));
  }

  Widget rceExpiration() {
    return DateAndStateFormField(
      dateTime: vehicle.rceExpiration ?? '',
      state: vehicle.rceState,
      labelText: 'Fecha de expiración Póliza Rce',
    );
  }

  Widget state() {
    return TextFormField(
        initialValue: vehicle.state,
        enabled: false,
        decoration: Utils.inputDecoration('Estado'));
  }
}
