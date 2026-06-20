import 'package:shared_preferences/shared_preferences.dart';
import '../utils/storage_keys.dart';

// Repository responsible for clearing all saved local data.
// We use it during logout to reset Remember Me, timer, selected image, etc.
class AppResetRepository {
  Future<void> clearAllSavedValues() async {
    // Get the SharedPreferences instance.
    final prefs = await SharedPreferences.getInstance();

    // Clear all saved values from local storage.
    await prefs.clear();
  }
}
