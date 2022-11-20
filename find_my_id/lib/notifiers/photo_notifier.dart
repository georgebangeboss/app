import 'dart:io';

import 'package:flutter/material.dart';

class PhotosNotifier extends ChangeNotifier {
  File? selectedPhoto;

  selectImage(File? file) {
    selectedPhoto = file;
    if (file != null) {
      print("JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ");
      print(file.path);
    }
  }

  removeImage(File file) {
    selectedPhoto = null;
  }
}
