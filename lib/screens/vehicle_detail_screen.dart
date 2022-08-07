import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/models/vehicle.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';
import 'package:ruta_al_sur_v2/widgets/date_and_state_form_field.dart';
import 'package:ruta_al_sur_v2/widgets/invalid_date.dart';
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
                      rceExpiration()
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
    final plainDate = Utils.validateDate(vehicle.soatExpiration);
    if (plainDate != vehicle.soatExpiration) {
      return InvalidDate(
          plainDate: plainDate, text: 'Fecha de expiración SOAT');
    }
    final dateTime = DateTime.parse(plainDate);

    return DateAndStateFormField(
      dateTime: dateTime,
      state: vehicle.soatState,
      labelText: 'Fecha de expiración SOAT',
    );
  }

  Widget technoReviewNumber() {
    return TextFormField(
        initialValue: '${vehicle.technoReviewNumber}',
        enabled: false,
        decoration:
            Utils.inputDecoration('Número de revisión tecnicomecánica'));
  }

  Widget technoReviewExpiration() {
    final plainDate = Utils.validateDate(vehicle.technoReviewExpiration);
    if (plainDate != vehicle.technoReviewExpiration) {
      return InvalidDate(
          plainDate: plainDate,
          text: 'Fecha de expiración revisión técnico mecánica');
    }

    final dateTime = DateTime.parse(plainDate);

    return DateAndStateFormField(
      dateTime: dateTime,
      state: vehicle.technoState,
      labelText: 'Fecha de expiración revisión técnico mecánica',
    );
  }

  Widget rcePolicy() {
    return TextFormField(
        initialValue: vehicle.rcePolicy,
        enabled: false,
        decoration: Utils.inputDecoration('Póliza Rce'));
  }

  Widget rceExpiration() {
    final plainDate = Utils.validateDate(vehicle.rceExpiration);
    if (plainDate != vehicle.rceExpiration) {
      return InvalidDate(
          plainDate: plainDate, text: 'Fecha de expiración póliza');
    }

    final dateTime = DateTime.parse(plainDate);

    return DateAndStateFormField(
      dateTime: dateTime,
      state: vehicle.rceState,
      labelText: 'Fecha de expiración',
    );
  }
}
