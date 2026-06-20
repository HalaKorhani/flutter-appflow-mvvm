import 'dart:io';

import 'package:flutter/material.dart';

import '../repositories/gallery_repository.dart';

// ViewModel responsible for gallery screen state and image selection logic.
class GalleryViewModel extends ChangeNotifier {
  final GalleryRepository _repository;

  GalleryViewModel(this._repository);

  File? selectedImage;
  bool permissionDenied = false;
  String? message;

  Future<void> loadSavedImage() async {
    // Load image path saved in SharedPreferences.
    final path = await _repository.loadSavedImagePath();

    // If the path exists and the file still exists on the device, display it.
    if (path != null && File(path).existsSync()) {
      selectedImage = File(path);
      notifyListeners();
    }
  }
}
