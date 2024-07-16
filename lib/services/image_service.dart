// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dartz/dartz.dart';
// import 'package:kailasoft_task/model/doctor_model.dart';

// late final FirebaseFirestore firestore;


//   // ADD BANNER
//   @override
//   Future<Object> addBanner(DoctorModel model) async {
//     try {
//       final query = firestore.collection('doctors').doc().id;
//       await firestore
//           .collection('doctors')
//           .doc(query)
//           .set(model.toMap());
//       return right(unit);
//     } catch (e) {
//       log('Error adding banner: ${e.toString()}');
//       return e;
//     }

    
//   }