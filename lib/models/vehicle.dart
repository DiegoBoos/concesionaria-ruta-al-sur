import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  String licensePlate;
  String soat;
  String soatExpiration;
  String rcePolicy1;
  String rcePolicy2;
  String rceExpiration1;
  String rceExpiration2;
  String propertyCardNumber;
  String technoReviewExpiration;
  String technoReviewNumber;
  String company;

  Vehicle(
      {required this.licensePlate,
      required this.soat,
      required this.soatExpiration,
      required this.rcePolicy1,
      required this.rcePolicy2,
      required this.rceExpiration1,
      required this.rceExpiration2,
      required this.propertyCardNumber,
      required this.technoReviewExpiration,
      required this.technoReviewNumber,
      required this.company});

  static Vehicle fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!;
    return Vehicle(
        licensePlate: map['licensePlate'],
        soat: map['soat'],
        soatExpiration: map['soatExpiration'],
        rcePolicy1: map['rcePolicy1'],
        rcePolicy2: map['rcePolicy2'],
        rceExpiration1: map['rceExpiration1'],
        rceExpiration2: map['rceExpiration2'],
        propertyCardNumber: map['propertyCardNumber'],
        technoReviewExpiration: map['technoReviewExpiration'],
        technoReviewNumber: map['technoReviewNumber'],
        company: map['company']);
  }

  static final today = DateTime.now();

  static String soatState(String soatExpiration) {
    final soatExpirationDt = DateTime.tryParse(soatExpiration);

    if (soatExpirationDt != null) {
      if (soatExpirationDt.isBefore(today)) {
        soatExpiration = "VENCIDO";
      } else if (soatExpirationDt.isAfter(today)) {
        soatExpiration = "VIGENTE";
      }
    } else if (soatExpiration == '') {
      soatExpiration = 'N/A';
    }
    return soatExpiration;
  }

  static String rceState1(String rceExpiration1) {
    final rceExpiration1Dt = DateTime.tryParse(rceExpiration1);

    if (rceExpiration1Dt != null) {
      if (rceExpiration1Dt.isBefore(today)) {
        rceExpiration1 = "VENCIDO";
      } else if (rceExpiration1Dt.isAfter(today)) {
        rceExpiration1 = "VIGENTE";
      }
    }
    return rceExpiration1;
  }

  static String rceState2(String rceExpiration2) {
    final rceExpiration2Dt = DateTime.tryParse(rceExpiration2);

    if (rceExpiration2Dt != null) {
      if (rceExpiration2Dt.isBefore(today)) {
        rceExpiration2 = "VENCIDO";
      } else if (rceExpiration2Dt.isAfter(today)) {
        rceExpiration2 = "VIGENTE";
      }
    }

    return rceExpiration2;
  }

  static String technoState(String technoReviewExpiration) {
    final technoReviewExpirationDt = DateTime.tryParse(technoReviewExpiration);

    if (technoReviewExpirationDt != null) {
      if (technoReviewExpirationDt.isBefore(today)) {
        technoReviewExpiration = "VENCIDO";
      } else if (technoReviewExpirationDt.isAfter(today)) {
        technoReviewExpiration = "VIGENTE";
      }
    } else if (technoReviewExpiration == 'N/A') {
      technoReviewExpiration = 'VIGENTE';
    } else if (technoReviewExpiration == '') {
      technoReviewExpiration = 'VENCIDO';
    }

    return technoReviewExpiration;
  }
}
