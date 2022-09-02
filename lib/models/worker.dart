import 'package:cloud_firestore/cloud_firestore.dart';

class Worker {
  String? afp;
  String? arl;
  String? caja;
  String? company;
  int consec;
  String document;
  String? eps;
  String? gender;
  String? induction;
  String? state;
  String? initialDate;
  String isEnabled;
  String? position;
  String workerFullName;

  Worker(
      {this.afp,
      this.arl,
      this.caja,
      this.company,
      required this.consec,
      required this.document,
      this.eps,
      this.gender,
      this.induction,
      this.state,
      this.initialDate,
      required this.isEnabled,
      this.position,
      required this.workerFullName});

  static Worker fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!;
    return Worker(
      afp: map['afp'],
      arl: map['arl'],
      caja: map['caja'],
      company: map['company'],
      consec: map['consec'],
      document: map['document'],
      eps: map['eps'],
      gender: map['gender'],
      induction: map['induction'],
      state: map['state'],
      initialDate: map['initialDate'],
      isEnabled: map['isEnabled'],
      position: map['position'],
      workerFullName: map['workerFullName'],
    );
  }
}
