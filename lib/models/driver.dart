import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  String? category;
  String? company;
  String? driverTestExpiration;
  String identification;
  String isEnabled;
  String? lastName;
  String? licenseExpiration;
  String? licenseNumber;
  String licenseState;
  String? medicalTestExpiration;
  String medicalTestState;
  String? name;

  Driver(
      {this.category,
      this.company,
      this.driverTestExpiration,
      required this.identification,
      required this.isEnabled,
      this.lastName,
      this.licenseExpiration,
      this.licenseNumber,
      required this.licenseState,
      this.medicalTestExpiration,
      required this.medicalTestState,
      this.name});

  static Driver fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!;
    return Driver(
      category: map['category'],
      company: map['company'],
      driverTestExpiration: map['driverTestExpiration'],
      identification: map['identification'],
      isEnabled: map['isEnabled'],
      lastName: map['lastName'],
      licenseExpiration: map['licenseExpiration'],
      licenseNumber: map['licenseNumber'],
      licenseState: map['licenseState'],
      medicalTestExpiration: map['medicalTestExpiration'],
      medicalTestState: map['medicalTestState'],
      name: map['name'],
    );
  }
}
