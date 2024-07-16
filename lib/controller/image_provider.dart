import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kailasoft_task/services/image_picker.dart';
import 'package:kailasoft_task/services/image_upload.dart';

class StorageProvider extends ChangeNotifier {
  bool isLoading = true;

  Uint8List? imageBytes;

  Future<void> setSelectedImage(File? image) async {
    if (image != null) {
      imageBytes = await image.readAsBytes();
    } else {
      imageBytes = null;
    }
    notifyListeners();
  }

  Future<void> pickImage(BuildContext context) async {
    final result = await ImagePick.pickImage(context);
    if (result != null) {
      imageBytes = result;

      notifyListeners();
    }
  }

//UPLOAD BANNER IMAGE
  Future<void> uploadBannerImage(BuildContext context) async {
    String? imageUrl;
    if (imageBytes != null) {
      final result = await ImageUpload.uploadImages(
        bytesImages: [imageBytes!],
        folderName: 'doctors',
      );

      result.fold(
        (error) {
          log('Error: ${error.toString()}');
        },
        (success) {
          imageUrl = success.toString();
          log('Image URL: $imageUrl');
        },
      );
    }
  }
}
