import 'package:flutter/material.dart';

class InvalidDate extends StatelessWidget {
  const InvalidDate({
    Key? key,
    required this.plainDate,
    required this.text,
  }) : super(key: key);

  final String plainDate;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(text, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 5),
        Text(plainDate, style: const TextStyle(fontSize: 17)),
        const Divider(color: Colors.grey)
      ],
    );
  }
}
