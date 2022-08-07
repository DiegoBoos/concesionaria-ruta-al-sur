import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';

class IsEnabledBanner extends StatelessWidget {
  const IsEnabledBanner(
      {Key? key, required this.isEnabled, required this.width})
      : super(key: key);

  final String isEnabled;
  final double width;

  @override
  Widget build(BuildContext context) {
    var buttonColor = isEnabled == 'SI'
        ? MaterialStateProperty.all(Utils.isEnabledColor)
        : MaterialStateProperty.all(Utils.isDisabledColor);
    return TextButton(
        onPressed: null,
        style: ButtonStyle(
            backgroundColor: buttonColor,
            fixedSize: MaterialStateProperty.all(Size.fromWidth(width))),
        child: Text(isEnabled == 'SI' ? 'Habilitado' : 'Deshabilitado',
            style: const TextStyle(color: Colors.white)));
  }
}
