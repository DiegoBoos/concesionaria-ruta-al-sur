import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/models/vehicle.dart';
import 'package:ruta_al_sur_v2/screens/vehicle_detail_screen.dart';
import 'package:ruta_al_sur_v2/services/vehicle_service.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';
import 'package:ruta_al_sur_v2/widgets/no_data_svg.dart';

class SearchVehicles extends SearchDelegate {
  final vehicleService = VehicleService();

  @override
  String? get searchFieldLabel => 'Buscar Vehículo';

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
    return StreamBuilder<List<Vehicle>>(
      stream: vehicleService.readVehicles,
      builder: (BuildContext context, AsyncSnapshot<List<Vehicle>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.hasData) {
          final vehicles = snapshot.data!;
          if (vehicles
              .where(
                  (Vehicle filteredVehicle) => filterVehicles(filteredVehicle))
              .isEmpty) {
            return const NoDataSvg(
                title: 'No hay resultados que coincidan con la búsqueda');
          }

          return ListView(children: [
            ...vehicles
                .where((Vehicle filteredVehicle) =>
                    filterVehicles(filteredVehicle))
                .map((Vehicle vehicle) => _VehicleTile(vehicle: vehicle))
          ]);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  bool filterVehicles(Vehicle filteredVehicle) {
    final licensePlate = filteredVehicle.licensePlate.toLowerCase().trim();

    return licensePlate.contains(query.trim());
  }
}

class _VehicleTile extends StatelessWidget {
  final Vehicle vehicle;

  const _VehicleTile({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final soatState = Vehicle.soatState(vehicle.soatExpiration.toString());
    final technoState =
        Vehicle.technoState(vehicle.technoReviewExpiration.toString());

    var buttonColor = (soatState == 'VIGENTE' && technoState == 'VIGENTE')
        ? MaterialStateProperty.all(Utils.isEnabledColor)
        : MaterialStateProperty.all(Utils.isDisabledColor);
    return ListTile(
        title: Text('${vehicle.licensePlate}'),
        subtitle: Text('${vehicle.company}'),
        trailing: TextButton(
            onPressed: null,
            style: ButtonStyle(
                backgroundColor: buttonColor,
                fixedSize:
                    MaterialStateProperty.all(const Size.fromWidth(130))),
            child: Text(
                (soatState == 'VIGENTE' && technoState == 'VIGENTE')
                    ? 'Habilitado'
                    : 'Deshabilitado',
                style: const TextStyle(color: Colors.white))),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VehicleDetailScreen(vehicle))));
  }
}
