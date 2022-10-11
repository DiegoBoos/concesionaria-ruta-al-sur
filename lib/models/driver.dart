import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  String name;
  String lastName;
  String identification;
  String licenseNumber;
  String category1;
  String category2;
  String category3;
  String categoryExpiration1;
  String categoryExpiration2;
  String categoryExpiration3;
  String medicalTestExpiration;
  String driverTestExpiration;
  String company;

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
        return "VENCIDO";
      } else if (categoryExpiration1Dt.isAfter(today)) {
        return "VIGENTE";
      }
    } else {
      return categoryExpiration1;
    }

    return '';
  }

  static String categoryState2(String categoryExpiration2) {
    if (categoryExpiration2 == '') return '';

    final categoryExpiration2Dt = DateTime.tryParse(categoryExpiration2);

    if (categoryExpiration2Dt != null) {
      if (categoryExpiration2Dt.isBefore(today)) {
        return "VENCIDO";
      } else if (categoryExpiration2Dt.isAfter(today)) {
        return "VIGENTE";
      }
    } else {
      return categoryExpiration2;
    }

    return '';
  }

  static String categoryState3(String categoryExpiration3) {
    if (categoryExpiration3 == '') return '';

    final categoryExpiration3Dt = DateTime.tryParse(categoryExpiration3);

    if (categoryExpiration3Dt != null) {
      if (categoryExpiration3Dt.isBefore(today)) {
        return "VENCIDO";
      } else if (categoryExpiration3Dt.isAfter(today)) {
        return "VIGENTE";
      }
    } else {
      return categoryExpiration3;
    }

    return '';
  }

  static String medicalTestState(String medicalTestExpiration) {
    if (medicalTestExpiration == '') return '';

    final medicalTestExpirationDt = DateTime.tryParse(medicalTestExpiration);

    if (medicalTestExpirationDt != null) {
      if (medicalTestExpirationDt.isBefore(today)) {
        return "VENCIDO";
      } else if (medicalTestExpirationDt.isAfter(today)) {
        return "VIGENTE";
      }
    } else {
      return medicalTestExpiration;
    }

    return '';
  }
}
