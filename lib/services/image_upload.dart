// image_upload_service.dart

import 'dart:developer';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUpload {
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static Future<Either> uploadImages({
    required List<Uint8List> bytesImages,
    required String folderName,
  }) async {
    try {
      List<Future<String>> uploadTasks = [];

      for (int i = 0; i < bytesImages.length; i++) {
        final storageRef = _firebaseStorage
            .ref()
            .child('doctors')
            .child('${DateTime.now().microsecondsSinceEpoch}image$i.jpeg');

        uploadTasks.add(storageRef
            .putData(
              bytesImages[i],
              SettableMetadata(contentType: 'image/jpeg'),
            )
            .then((value) => value.ref.getDownloadURL()));
      }

      List<String> imageUrls = await Future.wait(uploadTasks);

      return right(imageUrls);
    } on FirebaseException catch (e) {
      log('FirebaseException: ${e.code}');
      return left(e.code);
    }
  }
}
