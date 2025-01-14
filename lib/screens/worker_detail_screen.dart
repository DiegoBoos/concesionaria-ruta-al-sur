import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/models/worker.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';

class WorkerDetailScreen extends StatelessWidget {
  final Worker worker;
  const WorkerDetailScreen(this.worker, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: const Text('Detalle Trabajador')),
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
                      isEnabled(width),
                      consec(),
                      document(),
                      workerFullName(),
                      gender(),
                      position(),
                      induction(),
                      arl(),
                      eps(),
                      afp(),
                      caja(),
                      company(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

  Widget consec() {
    return TextFormField(
        initialValue: '${worker.consec}',
        enabled: false,
        decoration: Utils.inputDecoration('No.'));
  }

  Widget document() {
    return TextFormField(
        initialValue: '${worker.document}',
        enabled: false,
        decoration: Utils.inputDecoration('Documento'));
  }

  Widget workerFullName() {
    return TextFormField(
        initialValue: '${worker.workerFullName}',
        enabled: false,
        decoration: Utils.inputDecoration('Nombre Completo'));
  }

  Widget gender() {
    return TextFormField(
        initialValue: '${worker.gender}',
        enabled: false,
        decoration: Utils.inputDecoration('Género'));
  }

  Widget position() {
    return TextFormField(
        initialValue: '${worker.position}',
        enabled: false,
        decoration: Utils.inputDecoration('Descripción del cargo'));
  }

  Widget induction() {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            decoration: Utils.inputDecoration('Fecha Inicial'),
            initialValue: '${worker.initialDate}',
            enabled: false,
          ),
        ),
        Flexible(
          child: TextFormField(
              initialValue: '${worker.induction}',
              enabled: false,
              decoration: Utils.inputDecoration('Inducción')),
        ),
      ],
    );
  }

  Widget arl() {
    return TextFormField(
        initialValue: '${worker.arl}',
        enabled: false,
        decoration: Utils.inputDecoration('ARL'));
  }

  Widget eps() {
    return TextFormField(
        initialValue: '${worker.eps}',
        enabled: false,
        decoration: Utils.inputDecoration('EPS'));
  }

  Widget afp() {
    return TextFormField(
        initialValue: '${worker.afp}',
        enabled: false,
        decoration: Utils.inputDecoration('AFP'));
  }

  Widget caja() {
    return TextFormField(
        initialValue: '${worker.caja}',
        enabled: false,
        decoration: Utils.inputDecoration('Caja de compensación familiar'));
  }

  Widget company() {
    return TextFormField(
        initialValue: '${worker.company}',
        enabled: false,
        decoration: Utils.inputDecoration('Empresa'));
  }

  Widget isEnabled(double width) {
    var buttonColor = worker.isEnabled == 'SI'
        ? MaterialStateProperty.all(Utils.isEnabledColor)
        : MaterialStateProperty.all(Utils.isDisabledColor);

    return TextButton(
        onPressed: null,
        style: ButtonStyle(
            backgroundColor: buttonColor,
            fixedSize: MaterialStateProperty.all(Size.fromWidth(width))),
        child: Text(worker.isEnabled == 'SI' ? 'Habilitado' : 'Deshabilitado',
            style: const TextStyle(color: Colors.white)));
  }
}
