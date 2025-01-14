import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/models/driver.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';
import 'package:ruta_al_sur_v2/widgets/date_and_state_form_field.dart';

class DriverDetailScreen extends StatelessWidget {
  final Driver driver;
  const DriverDetailScreen(this.driver, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                isEnabledBanner(width, driver),
                fullName(),
                identification(),
                licenseNumber(),
                category1(),
                category2(),
                category3(),
                categoryExpiration1(),
                categoryExpiration2(),
                categoryExpiration3(),
                medicalTestExpiration(),
                driverTestExpiration(),
                company(),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget isEnabledBanner(double width, Driver driver) {
    final categoryState1 =
        Driver.categoryState1(driver.categoryExpiration1.toString());
    final medicalTestState =
        Driver.medicalTestState(driver.medicalTestExpiration.toString());
    final driverTestState =
        Driver.driverTestState(driver.driverTestExpiration.toString());

    var buttonColor = (categoryState1 == 'VIGENTE' &&
            medicalTestState == 'VIGENTE' &&
            driverTestState == 'VIGENTE')
        ? MaterialStateProperty.all(Utils.isEnabledColor)
        : MaterialStateProperty.all(Utils.isDisabledColor);
    return TextButton(
        onPressed: null,
        style: ButtonStyle(
            backgroundColor: buttonColor,
            fixedSize: MaterialStateProperty.all(Size.fromWidth(width))),
        child: Text(
            (categoryState1 == 'VIGENTE' &&
                    medicalTestState == 'VIGENTE' &&
                    driverTestState == 'VIGENTE')
                ? 'Habilitado'
                : 'Deshabilitado',
            style: const TextStyle(color: Colors.white)));
  }

  Widget fullName() {
    return TextFormField(
        initialValue: '${driver.name} ${driver.lastName}',
        enabled: false,
        decoration: Utils.inputDecoration('Nombre Completo'));
  }

  Widget identification() {
    return TextFormField(
        initialValue: '${driver.identification}',
        enabled: false,
        decoration: Utils.inputDecoration('Identificación'));
  }

  Widget licenseNumber() {
    return TextFormField(
        initialValue: '${driver.licenseNumber}',
        enabled: false,
        decoration: Utils.inputDecoration('Número de licencia'));
  }

  Widget category1() {
    return TextFormField(
        initialValue: '${driver.category1}',
        enabled: false,
        decoration: Utils.inputDecoration('Categoría 1'));
  }

  Widget category2() {
    return driver.category2 != ''
        ? TextFormField(
            initialValue: driver.category2.toString(),
            enabled: false,
            decoration: Utils.inputDecoration('Categoría 2'))
        : Container();
  }

  Widget category3() {
    return driver.category3 != ''
        ? TextFormField(
            initialValue: driver.category3.toString(),
            enabled: false,
            decoration: Utils.inputDecoration('Categoría 3'))
        : Container();
  }

  Widget categoryExpiration1() {
    return DateAndStateFormField(
      date: driver.categoryExpiration1.toString(),
      state: Driver.categoryState1(driver.categoryExpiration1.toString()),
      labelText: 'Fecha de expiración categoría 1',
    );
  }

  Widget categoryExpiration2() {
    return driver.categoryExpiration2 != ''
        ? DateAndStateFormField(
            date: driver.categoryExpiration2.toString(),
            state: Driver.categoryState2(driver.categoryExpiration2.toString()),
            labelText: 'Fecha de expiración categoría 2',
          )
        : Container();
  }

  Widget categoryExpiration3() {
    return driver.categoryExpiration3 != ''
        ? DateAndStateFormField(
            date: driver.categoryExpiration3.toString(),
            state: Driver.categoryState3(driver.categoryExpiration3.toString()),
            labelText: 'Fecha de expiración categoría 3',
          )
        : Container();
  }

  Widget medicalTestExpiration() {
    return driver.medicalTestExpiration != ''
        ? DateAndStateFormField(
            date: driver.medicalTestExpiration.toString(),
            state: Driver.medicalTestState(
                driver.medicalTestExpiration.toString()),
            labelText: 'Fecha de expiración examen médico ocupacional',
          )
        : Container();
  }

  Widget driverTestExpiration() {
    return DateAndStateFormField(
      date: driver.driverTestExpiration != ''
          ? driver.driverTestExpiration.toString()
          : 'N/A',
      labelText: 'Fecha de expiración examen de manejo a la defensiva',
    );
  }

  Widget company() {
    return TextFormField(
        initialValue: '${driver.company}',
        enabled: false,
        decoration: Utils.inputDecoration('Empresa'));
  }
}
