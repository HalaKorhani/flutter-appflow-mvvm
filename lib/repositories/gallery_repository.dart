import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/storage_keys.dart';

class GalleryRepository {
  final ImagePicker _picker = ImagePicker();

  Future<String?> loadSavedImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageKeys.selectedImagePath);
  }

  Future<void> saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(StorageKeys.selectedImagePath, path);
  }

  Future<void> clearImage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(StorageKeys.selectedImagePath);
  }

  Future<bool> requestGalleryPermission() async {
    // On Android 13+, Permission.photos maps to media images access.
    // On older Android versions, storage permission is used.
    final photosStatus = await Permission.photos.request();
    if (photosStatus.isGranted || photosStatus.isLimited) {
      return true;
    }

    final storageStatus = await Permission.storage.request();
    return storageStatus.isGranted;
  }

  Future<File?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }
}
