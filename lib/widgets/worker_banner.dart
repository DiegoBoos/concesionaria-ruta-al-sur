import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';

class WorkerBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;

  const WorkerBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Utils.green, Utils.lightGreen]),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:30.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInRight(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeInLeft(
                    child: Text(

                      subtitle,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.only(right: 30.0, top: 10,bottom: 10),
            child: BounceInDown(
              delay: const Duration(milliseconds: 500),
              child: Image.asset(
                image,
                height: 100,
              ),
            ),
          )
        ],
      ),
    );
  }
}
