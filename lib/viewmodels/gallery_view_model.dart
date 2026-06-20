import 'dart:io';

import 'package:flutter/material.dart';

import '../repositories/gallery_repository.dart';

class GalleryViewModel extends ChangeNotifier {
  final GalleryRepository _repository;

  GalleryViewModel(this._repository);

  File? selectedImage;
  bool permissionDenied = false;
  String? message;

  Future<void> loadSavedImage() async {
    final path = await _repository.loadSavedImagePath();
    if (path != null && File(path).existsSync()) {
      selectedImage = File(path);
      notifyListeners();
    }
  }

  Future<void> pickImage() async {
    permissionDenied = false;
    message = null;
    notifyListeners();

    final allowed = await _repository.requestGalleryPermission();
    if (!allowed) {
      permissionDenied = true;
      message =
          'Permission denied. Please allow media permission to select an image.';
      notifyListeners();
      return;
    }

    final image = await _repository.pickImage();
    if (image == null) {
      message = 'No image selected.';
      notifyListeners();
      return;
    }

    selectedImage = image;
    await _repository.saveImagePath(image.path);
    notifyListeners();
  }

  Future<void> reset() async {
    selectedImage = null;
    permissionDenied = false;
    message = null;
    await _repository.clearImage();
    notifyListeners();
  }
}
