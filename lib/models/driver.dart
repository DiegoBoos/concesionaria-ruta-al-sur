import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  dynamic name;
  dynamic lastName;
  dynamic identification;
  dynamic licenseNumber;
  dynamic category1;
  dynamic category2;
  dynamic category3;
  dynamic categoryExpiration1;
  dynamic categoryExpiration2;
  dynamic categoryExpiration3;
  dynamic medicalTestExpiration;
  dynamic driverTestExpiration;
  dynamic company;

  Driver(
      {required this.name,
      required this.lastName,
      required this.identification,
      required this.licenseNumber,
      required this.category1,
      required this.category2,
      required this.category3,
      required this.categoryExpiration1,
      required this.categoryExpiration2,
      required this.categoryExpiration3,
      required this.medicalTestExpiration,
      required this.driverTestExpiration,
      required this.company});

  static Driver fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!;
    return Driver(
        name: map['name'],
        lastName: map['lastName'],
        identification: map['identification'],
        licenseNumber: map['licenseNumber'],
        category1: map['category1'],
        category2: map['category2'],
        category3: map['category3'],
        categoryExpiration1: map['categoryExpiration1'],
        categoryExpiration2: map['categoryExpiration2'],
        categoryExpiration3: map['categoryExpiration3'],
        medicalTestExpiration: map['medicalTestExpiration'],
        driverTestExpiration: map['driverTestExpiration'],
        company: map['company']);
  }

  static final today = DateTime.now();

  static String categoryState1(String categoryExpiration1) {
    final categoryExpiration1Dt = DateTime.tryParse(categoryExpiration1);

    if (categoryExpiration1Dt != null) {
      if (categoryExpiration1Dt.isBefore(today)) {
        categoryExpiration1 = "VENCIDO";
      } else if (categoryExpiration1Dt.isAfter(today)) {
        categoryExpiration1 = "VIGENTE";
      }
    }

    return categoryExpiration1;
  }

  static String categoryState2(String categoryExpiration2) {
    final categoryExpiration2Dt = DateTime.tryParse(categoryExpiration2);

    if (categoryExpiration2Dt != null) {
      if (categoryExpiration2Dt.isBefore(today)) {
        categoryExpiration2 = "VENCIDO";
      } else if (categoryExpiration2Dt.isAfter(today)) {
        categoryExpiration2 = "VIGENTE";
      }
    }

    return categoryExpiration2;
  }

  static String categoryState3(String categoryExpiration3) {
    final categoryExpiration3Dt = DateTime.tryParse(categoryExpiration3);

    if (categoryExpiration3Dt != null) {
      if (categoryExpiration3Dt.isBefore(today)) {
        categoryExpiration3 = "VENCIDO";
      } else if (categoryExpiration3Dt.isAfter(today)) {
        categoryExpiration3 = "VIGENTE";
      }
    }
    return categoryExpiration3;
  }

  static String medicalTestState(String medicalTestExpiration) {
    final medicalTestExpirationDt = DateTime.tryParse(medicalTestExpiration);

    if (medicalTestExpirationDt != null) {
      if (medicalTestExpirationDt.isBefore(today)) {
        medicalTestExpiration = "VENCIDO";
      } else if (medicalTestExpirationDt.isAfter(today)) {
        medicalTestExpiration = "VIGENTE";
      }
    }
    return medicalTestExpiration;
  }

  static String driverTestState(String driverTestExpiration) {
    final driverTestExpirationDt = DateTime.tryParse(driverTestExpiration);

    if (driverTestExpirationDt != null) {
      if (driverTestExpirationDt.isBefore(today)) {
        driverTestExpiration = "VENCIDO";
      } else if (driverTestExpirationDt.isAfter(today)) {
        driverTestExpiration = "VIGENTE";
      }
    }
    return driverTestExpiration;
  }
}
