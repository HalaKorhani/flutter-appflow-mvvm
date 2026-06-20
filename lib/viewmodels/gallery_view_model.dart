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

  Future<void> pickImage() async {
    // Reset old messages before choosing a new image.
    permissionDenied = false;
    message = null;
    notifyListeners();

    // Ask repository to request gallery/media permission.
    final allowed = await _repository.requestGalleryPermission();

    if (!allowed) {
      permissionDenied = true;
      message =
          'Permission denied. Please allow media permission to select an image.';
      notifyListeners();
      return;
    }

    // Open the gallery picker.
    final image = await _repository.pickImage();

    if (image == null) {
      message = 'No image selected.';
      notifyListeners();
      return;
    }

    // Save selected image in ViewModel state and local storage.
    selectedImage = image;
    await _repository.saveImagePath(image.path);
    notifyListeners();
  }

  Future<void> reset() async {
    // Clear UI state.
    selectedImage = null;
    permissionDenied = false;
    message = null;

    // Clear saved image path from local storage.
    await _repository.clearImage();

    notifyListeners();
  }
}
