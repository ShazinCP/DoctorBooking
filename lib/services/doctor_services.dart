import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kailasoft_task/model/doctor_model.dart';

class DoctorServices {
  
  final CollectionReference _firebase =
      FirebaseFirestore.instance.collection('doctors');


  Future<List<DoctorModel>> fetchDoctors() async {
    final snapshot = await _firebase.get();
    return snapshot.docs.map((doc) {
      return DoctorModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  void addDoctor(DoctorModel doctor) {
    final data = doctor.toMap();
    _firebase.add(data);
  }

  void updateDoctor(DoctorModel doctor) {
    final data = doctor.toMap();
    _firebase.doc(doctor.id).update(data);
  }

  void deleteDoctor(String docId) {
    _firebase.doc(docId).delete();
  }
  
}
