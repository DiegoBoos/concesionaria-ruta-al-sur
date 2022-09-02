import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  String? company;
  String isEnabled;
  String licensePlate;
  String? propertyCardNumber;
  String? rceExpiration;
  String? rcePolicy;
  String rceState;
  String? soat;
  String? soatExpiration;
  String soatState;
  String? technoReviewExpiration;
  String? technoReviewNumber;
  String technoState;
  String? state;

  Vehicle(
      {this.company,
      required this.isEnabled,
      required this.licensePlate,
      this.propertyCardNumber,
      this.rceExpiration,
      this.rcePolicy,
      required this.rceState,
      this.soat,
      this.soatExpiration,
      required this.soatState,
      this.technoReviewExpiration,
      this.technoReviewNumber,
      required this.technoState,
      this.state});

  static Vehicle fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!;
    return Vehicle(
      company: map['company'],
      isEnabled: map['isEnabled'],
      licensePlate: map['licensePlate'],
      propertyCardNumber: map['propertyCardNumber'],
      rceExpiration: map['rceExpiration'],
      rcePolicy: map['rcePolicy'],
      rceState: map['rceState'],
      soat: map['soat'],
      soatExpiration: map['soatExpiration'],
      soatState: map['soatState'],
      technoReviewExpiration: map['technoReviewExpiration'],
      technoReviewNumber: map['technoReviewNumber'],
      technoState: map['technoState'],
      state: map['state'],
    );
  }
}
