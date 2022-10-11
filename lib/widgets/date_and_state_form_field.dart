import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';

class DateAndStateFormField extends StatelessWidget {
  const DateAndStateFormField({
    Key? key,
    required this.date,
    this.state,
    required this.labelText,
  }) : super(key: key);

  final String date;
  final String? state;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    var buttonColor = state == 'VIGENTE'
        ? MaterialStateProperty.all(Utils.isEnabledColor)
        : MaterialStateProperty.all(Utils.isDisabledColor);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 2,
            child: TextFormField(
              decoration: Utils.inputDecoration(labelText),
              initialValue: date,
              enabled: false,
            )),
        if (state != null)
          Flexible(
            child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextButton(
                    onPressed: null,
                    style: ButtonStyle(backgroundColor: buttonColor),
                    child: Text(state!,
                        style: const TextStyle(color: Colors.white)))),
          ),
      ],
    );
  }
}
