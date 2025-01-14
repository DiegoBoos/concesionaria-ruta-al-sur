import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/models/vehicle.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';
import 'package:ruta_al_sur_v2/widgets/date_and_state_form_field.dart';

class VehicleDetailScreen extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleDetailScreen(this.vehicle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      isEnabledBanner(width, vehicle),
                      licensePlate(),
                      soat(),
                      soatExpiration(),
                      rcePolicy1(),
                      rceExpiration1(),
                      rcePolicy2(),
                      rceExpiration2(),
                      propertyCardNumber(),
                      technoReviewNumber(),
                      technoReviewExpiration(),
                      company(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

  Widget isEnabledBanner(double width, Vehicle vehicle) {
    final soatState = Vehicle.soatState(vehicle.soatExpiration.toString());
    final rceState1 = Vehicle.rceState1(vehicle.rceExpiration1.toString());
    final technoState =
        Vehicle.technoState(vehicle.technoReviewExpiration.toString());

    var buttonColor =
        validateIsEnabled(soatState, rceState1, technoState, vehicle)
            ? MaterialStateProperty.all(Utils.isEnabledColor)
            : MaterialStateProperty.all(Utils.isDisabledColor);
    return TextButton(
        onPressed: null,
        style: ButtonStyle(
            backgroundColor: buttonColor,
            fixedSize: MaterialStateProperty.all(Size.fromWidth(width))),
        child: Text(
            validateIsEnabled(soatState, rceState1, technoState, vehicle)
                ? 'Habilitado'
                : 'Deshabilitado',
            style: const TextStyle(color: Colors.white)));
  }

  bool validateIsEnabled(
      String soatState, String rceState1, String technoState, Vehicle vehicle) {
    if (vehicle.technoReviewExpiration == 'N/A' ||
        vehicle.technoReviewExpiration == '') {
      if (soatState == 'VIGENTE' && rceState1 == 'VIGENTE') {
        return true;
      }
    } else {
      if (soatState == 'VIGENTE' &&
          rceState1 == 'VIGENTE' &&
          technoState == 'VIGENTE') {
        return true;
      }
    }
    return false;
  }

  Widget licensePlate() {
    return TextFormField(
        initialValue: '${vehicle.licensePlate}',
        enabled: false,
        decoration: Utils.inputDecoration('Placa'));
  }

  Widget soat() {
    return TextFormField(
        initialValue: '${vehicle.soat ?? 'N/A'}',
        enabled: false,
        decoration: Utils.inputDecoration('SOAT'));
  }

  Widget soatExpiration() {
    return DateAndStateFormField(
      date: vehicle.soatExpiration.toString(),
      state: Vehicle.soatState(vehicle.soatExpiration.toString()),
      labelText: 'Fecha de expiración SOAT',
    );
  }

  Widget rcePolicy1() {
    return TextFormField(
        initialValue: '${vehicle.rcePolicy1}',
        enabled: false,
        decoration: Utils.inputDecoration('Póliza Rce 1'));
  }

  Widget rceExpiration1() {
    return DateAndStateFormField(
      date: '${vehicle.rceExpiration1}',
      state: Vehicle.rceState1(vehicle.rceExpiration1.toString()),
      labelText: 'Fecha de expiración Póliza Rce 1',
    );
  }

  Widget rcePolicy2() {
    return vehicle.rcePolicy2 != ''
        ? TextFormField(
            initialValue: vehicle.rcePolicy2.toString(),
            enabled: false,
            decoration: Utils.inputDecoration('Póliza Rce 2'))
        : Container();
  }

  Widget rceExpiration2() {
    return vehicle.rceExpiration2 != ''
        ? DateAndStateFormField(
            date: vehicle.rceExpiration2.toString(),
            state: Vehicle.rceState2(vehicle.rceExpiration2.toString()),
            labelText: 'Fecha de expiración Póliza Rce 2',
          )
        : Container();
  }

  Widget propertyCardNumber() {
    return TextFormField(
        initialValue: '${vehicle.propertyCardNumber}',
        enabled: false,
        decoration: Utils.inputDecoration('Tarjeta de propiedad'));
  }

  Widget technoReviewExpiration() {
    if (vehicle.technoReviewExpiration == 'N/A') {
      vehicle.technoReviewExpiration = 'N/A';
    } else if (vehicle.technoReviewExpiration == '') {
      vehicle.technoReviewExpiration = '';
    }
    return DateAndStateFormField(
      date: vehicle.technoReviewExpiration.toString(),
      state: Vehicle.technoState(vehicle.technoReviewExpiration.toString()),
      labelText: 'Fecha de expiración tecnomecánica',
    );
  }

  Widget technoReviewNumber() {
    return TextFormField(
        initialValue: '${vehicle.technoReviewNumber}',
        enabled: false,
        decoration: Utils.inputDecoration('Número de revisión tecnomecánica'));
  }

  Widget company() {
    return TextFormField(
        initialValue: '${vehicle.company}',
        enabled: false,
        decoration: Utils.inputDecoration('Empresa'));
  }
}
