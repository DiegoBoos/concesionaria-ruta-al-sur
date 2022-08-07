import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/worker.dart';

class WorkerService {
  Stream<List<Worker>> readWorkers = FirebaseFirestore.instance
      .collection('workers')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Worker.fromSnapshot(doc)).toList());
}
