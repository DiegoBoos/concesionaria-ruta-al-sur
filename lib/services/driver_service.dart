import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/driver.dart';

class DriverService {
  Stream<List<Driver>> readDrivers = FirebaseFirestore.instance
      .collection('drivers')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Driver.fromSnapshot(doc)).toList());
}
