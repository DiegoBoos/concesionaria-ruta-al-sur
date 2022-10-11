import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/models/driver.dart';
import 'package:ruta_al_sur_v2/screens/driver_detail_screen.dart';
import 'package:ruta_al_sur_v2/services/driver_service.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';
import 'package:ruta_al_sur_v2/widgets/no_data_svg.dart';

class SearchDrivers extends SearchDelegate {
  final driverService = DriverService();

  @override
  String? get searchFieldLabel => 'Buscar Conductor';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return const NoDataSvg(title: 'Escriba para buscar');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const NoDataSvg(title: 'Escriba para buscar');
    }
    return StreamBuilder<List<Driver>>(
      stream: driverService.readDrivers,
      builder: (BuildContext context, AsyncSnapshot<List<Driver>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.hasData) {
          final drivers = snapshot.data!;
          if (drivers
              .where((Driver filteredDriver) => filterDrivers(filteredDriver))
              .isEmpty) {
            return const NoDataSvg(
                title: 'No hay resultados que coincidan con la búsqueda');
          }

          return ListView(children: [
            ...drivers
                .where((Driver filteredDriver) => filterDrivers(filteredDriver))
                .map((Driver driver) => _DriverTile(driver: driver))
          ]);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  bool filterDrivers(Driver filteredDriver) {
    final identification =
        filteredDriver.identification.toString().toLowerCase().trim();

    return identification.contains(query.trim());
  }
}

class _DriverTile extends StatelessWidget {
  final Driver driver;

  const _DriverTile({required this.driver});

  @override
  Widget build(BuildContext context) {
    final categoryState1 = Driver.categoryState1(driver.categoryExpiration1);

    final medicalTestState =
        Driver.medicalTestState(driver.medicalTestExpiration);

    var buttonColor =
        (categoryState1 == 'VIGENTE' && medicalTestState == 'VIGENTE')
            ? MaterialStateProperty.all(Utils.isEnabledColor)
            : MaterialStateProperty.all(Utils.isDisabledColor);
    return ListTile(
        title: Text('${driver.name} ${driver.lastName}'),
        subtitle: Text(driver.identification),
        trailing: TextButton(
            onPressed: null,
            style: ButtonStyle(
                backgroundColor: buttonColor,
                fixedSize:
                    MaterialStateProperty.all(const Size.fromWidth(130))),
            child: Text(
                (categoryState1 == 'VIGENTE' && medicalTestState == 'VIGENTE')
                    ? 'Habilitado'
                    : 'Deshabilitado',
                style: const TextStyle(color: Colors.white))),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DriverDetailScreen(driver))));
  }
}
