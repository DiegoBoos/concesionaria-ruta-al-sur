import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/models/worker.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';
import 'package:ruta_al_sur_v2/widgets/invalid_date.dart';
import 'package:ruta_al_sur_v2/widgets/is_enabled_banner.dart';

class WorkerDetailScreen extends StatelessWidget {
  final Worker worker;
  const WorkerDetailScreen(this.worker, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isEnabled = worker.isEnabled;
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
                      IsEnabledBanner(isEnabled: isEnabled, width: width),
                      consec(),
                      document(),
                      workerFullName(),
                      gender(),
                      induction(),
                      afp(),
                      arl(),
                      caja(),
                      company(),
                      eps(),
                      position()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

  Widget isEnabled(BuildContext context) {
    var buttonColor = worker.isEnabled == 'SI'
        ? MaterialStateProperty.all(Utils.isEnabledColor)
        : MaterialStateProperty.all(Utils.isDisabledColor);
    final width = MediaQuery.of(context).size.width;
    return TextButton(
        onPressed: null,
        style: ButtonStyle(
            backgroundColor: buttonColor,
            fixedSize: MaterialStateProperty.all(Size.fromWidth(width))),
        child: Text(worker.isEnabled == 'SI' ? 'Habilitado' : 'Deshabilitado',
            style: const TextStyle(color: Colors.white)));
  }

  Widget consec() {
    return TextFormField(
        initialValue: '${worker.consec}',
        enabled: false,
        decoration: Utils.inputDecoration('No.'));
  }

  Widget document() {
    return TextFormField(
        initialValue: worker.document.toString(),
        enabled: false,
        decoration: Utils.inputDecoration('Documento'));
  }

  Widget workerFullName() {
    return TextFormField(
        initialValue: worker.workerFullName,
        enabled: false,
        decoration: Utils.inputDecoration('Nombre Completo'));
  }

  Widget gender() {
    return TextFormField(
        initialValue: worker.gender,
        enabled: false,
        decoration: Utils.inputDecoration('Género'));
  }

  Widget induction() {
    final plainDate = Utils.validateDate(worker.initialDate);
    if (plainDate != worker.initialDate) {
      return InvalidDate(
          plainDate: plainDate, text: 'Fecha de expiración SOAT');
    }
    final dateTime = DateTime.parse(plainDate);

    return Row(
      children: [
        Flexible(
          flex: 2,
          child: InputDatePickerFormField(
            fieldLabelText: 'Fecha Inicial',
            initialDate: dateTime,
            firstDate: DateTime.utc(1845, 01, 01),
            lastDate: DateTime.utc(3000, 01, 01),
          ),
        ),
        Flexible(
          child: TextFormField(
              initialValue: worker.induction,
              enabled: false,
              decoration: Utils.inputDecoration('Inducción')),
        ),
      ],
    );
  }

  Widget afp() {
    return TextFormField(
        initialValue: worker.afp,
        enabled: false,
        decoration: Utils.inputDecoration('AFP'));
  }

  Widget arl() {
    return TextFormField(
        initialValue: worker.arl,
        enabled: false,
        decoration: Utils.inputDecoration('ARL'));
  }

  Widget caja() {
    return TextFormField(
        initialValue: worker.caja,
        enabled: false,
        decoration: Utils.inputDecoration('Caja de compensación familiar'));
  }

  Widget company() {
    return TextFormField(
        initialValue: worker.company,
        enabled: false,
        decoration: Utils.inputDecoration('Empresa'));
  }

  Widget eps() {
    return TextFormField(
        initialValue: worker.eps,
        enabled: false,
        decoration: Utils.inputDecoration('EPS'));
  }

  Widget position() {
    return TextFormField(
        initialValue: worker.position,
        enabled: false,
        decoration: Utils.inputDecoration('Descripción del cargo'));
  }
}
