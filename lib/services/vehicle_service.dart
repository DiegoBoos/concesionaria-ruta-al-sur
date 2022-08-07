import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/vehicle.dart';

class VehicleService {
  Stream<List<Vehicle>> readVehicles = FirebaseFirestore.instance
      .collection('vehicles')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Vehicle.fromSnapshot(doc)).toList());
}
