import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_ruta.dart';

class UserRutaService {
  Future<UserRuta> getUserRuta(String email) async {
    return await FirebaseFirestore.instance
        .collection('usersruta')
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return UserRuta.fromJson(value.docs[0].data());
      }
      return Future.error('Error al cargar la información del usuario');
    });
  }
}
