import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/models/worker.dart';
import 'package:ruta_al_sur_v2/screens/worker_detail_screen.dart';
import 'package:ruta_al_sur_v2/services/worker_service.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';
import 'package:ruta_al_sur_v2/widgets/no_data_svg.dart';

class SearchWorkers extends SearchDelegate {
  final workerService = WorkerService();

  @override
  String? get searchFieldLabel => 'Buscar Trabajador';

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
    return StreamBuilder<List<Worker>>(
      stream: workerService.readWorkers,
      builder: (BuildContext context, AsyncSnapshot<List<Worker>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.hasData) {
          final workers = snapshot.data!;
          if (workers
              .where((Worker filteredWorker) => filterWorkers(filteredWorker))
              .isEmpty) {
            return const NoDataSvg(
                title: 'No hay resultados que coincidan con la búsqueda');
          }

          return ListView(children: [
            ...workers
                .where((Worker filteredWorker) => filterWorkers(filteredWorker))
                .map((Worker worker) => _WorkerTile(worker: worker))
          ]);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  bool filterWorkers(Worker filteredWorker) {
    final document = filteredWorker.document.toLowerCase().trim();

    return document.contains(query.trim());
  }
}

class _WorkerTile extends StatelessWidget {
  final Worker worker;

  const _WorkerTile({required this.worker});

  @override
  Widget build(BuildContext context) {
    var buttonColor = worker.isEnabled == 'SI'
        ? MaterialStateProperty.all(Utils.isEnabledColor)
        : MaterialStateProperty.all(Utils.isDisabledColor);
    return ListTile(
        title: Text(worker.workerFullName),
        subtitle: Text(worker.document),
        trailing: TextButton(
            onPressed: null,
            style: ButtonStyle(
                backgroundColor: buttonColor,
                fixedSize:
                    MaterialStateProperty.all(const Size.fromWidth(130))),
            child: Text(
                worker.isEnabled == 'SI' ? 'Habilitado' : 'Deshabilitado',
                style: const TextStyle(color: Colors.white))),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WorkerDetailScreen(worker))));
  }
}
