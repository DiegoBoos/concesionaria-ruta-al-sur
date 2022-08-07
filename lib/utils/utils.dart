import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar(String? text, [Color color = Colors.red]) {
    if (text == null) return;

    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: color,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static const Color lightGreen = Color(0xff22B57A);
  static const Color green = Color(0xff209B1D);
  static const Color yellow = Color(0xffFADA3C);

  static Color isEnabledColor = const Color.fromARGB(180, 76, 175, 79);
  static Color isDisabledColor = const Color.fromARGB(180, 244, 67, 54);

  static InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
    );
  }

  static String validateDate(String? expirationDate) {
    if (expirationDate == '') {
      return 'No registra';
    }

    return expirationDate!;
  }

  static List<BoxShadow> shadowList = [
    BoxShadow(
        color: Colors.grey[300]!, blurRadius: 30, offset: const Offset(0, 10))
  ];
}
