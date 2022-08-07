import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  @required
  final String text;
  final Color firstColor;
  final Color secondColor;
  final Function() onPressed;

  // ignore: use_key_in_widget_constructors
  const CustomButton(
      {required this.icon,
      required this.text,
      this.firstColor = Colors.grey,
      this.secondColor = Colors.blue,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          _CustomButtonBackground(icon, firstColor, secondColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 140, width: 40),
              Icon(icon, color: Colors.white, size: 40),
              const SizedBox(width: 20),
              Expanded(
                child: Text(text,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    )),
              ),
              const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
              ),
              const SizedBox(width: 40),
            ],
          )
        ],
      ),
    );
  }
}

class _CustomButtonBackground extends StatelessWidget {
  final IconData icon;
  final Color firstColor;
  final Color secondColor;

  const _CustomButtonBackground(this.icon, this.firstColor, this.secondColor);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(4, 6),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: [firstColor, secondColor])),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child:
                  Icon(icon, size: 150, color: Colors.white.withOpacity(0.2)),
            )
          ],
        ),
      ),
    );
  }
}
