import 'package:shared_preferences/shared_preferences.dart';

import '../utils/storage_keys.dart';

// Repository responsible for saving, loading, and clearing timer data.
// This allows the timer to continue from the saved value after app restart.
class TimerRepository {
  Future<int> loadSeconds() async {
    // Get saved timer seconds from local storage.
    final prefs = await SharedPreferences.getInstance();

    // If no saved value exists, return 0.
    return prefs.getInt(StorageKeys.timerSeconds) ?? 0;
  }

  Future<void> saveSeconds(int seconds) async {
    // Save the current timer seconds.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(StorageKeys.timerSeconds, seconds);
  }

  Future<void> clearTimer() async {
    // Remove timer value when the user logs out.
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(StorageKeys.timerSeconds);
  }
}
