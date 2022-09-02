import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';

class DateAndStateFormField extends StatelessWidget {
  const DateAndStateFormField({
    Key? key,
    required this.dateTime,
    this.state,
    required this.labelText,
  }) : super(key: key);

  final String dateTime;
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
        /* Flexible(
          flex: 2,
          child: InputDatePickerFormField(
            fieldLabelText: labelText,
            initialDate: dateTime,
            firstDate: DateTime.utc(1845, 01, 01),
            lastDate: DateTime.utc(3000, 01, 01),
          ),
        ), */
        Flexible(
            flex: 2,
            child: TextFormField(
              decoration: Utils.inputDecoration(labelText),
              initialValue: dateTime,
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
