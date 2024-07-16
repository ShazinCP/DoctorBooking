import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


class ImagePick {
  static final _imagePicker = ImagePicker();

  static Future<Uint8List?> pickImage(
    BuildContext context,
  ) async {
    const maxFileSize = 1024 * 199;
    try {
     
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return null;
   

      final pickedImageBytes = await pickedFile.readAsBytes();
   
      if (pickedImageBytes.length > maxFileSize) {
        return null;
      } else {
        return pickedImageBytes;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
    }
}
  