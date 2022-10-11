import 'package:cloud_firestore/cloud_firestore.dart';

class Worker {
  String consec;
  String document;
  String workerFullName;
  String gender;
  String position;
  String initialDate;
  String induction;
  String arl;
  String eps;
  String afp;
  String caja;
  String isEnabled;
  String company;

  Worker(
      {required this.consec,
      required this.document,
      required this.workerFullName,
      required this.gender,
      required this.position,
      required this.initialDate,
      required this.induction,
      required this.arl,
      required this.eps,
      required this.afp,
      required this.caja,
      required this.isEnabled,
      required this.company});

  static Worker fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!;
    return Worker(
        consec: map['consec'],
        document: map['document'],
        workerFullName: map['workerFullName'],
        gender: map['gender'],
        position: map['position'],
        initialDate: map['initialDate'],
        induction: map['induction'],
        arl: map['arl'],
        eps: map['eps'],
        afp: map['afp'],
        caja: map['caja'],
        isEnabled: map['isEnabled'],
        company: map['company']);
  }
}
