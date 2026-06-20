import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_user.dart';
import '../utils/storage_keys.dart';

class AuthRepository {
  // The two predefined login accounts required by the assignment.
  final List<AppUser> _users = const [
    AppUser(username: 'student', password: 'student123'),
    AppUser(username: 'admin', password: 'admin123'),
  ];

  // Checks whether the username/password match one of the predefined accounts.
  bool validateLogin(String username, String password) {
    return _users.any(
      (user) => user.username == username.trim() && user.password == password,
    );
  }

  // Checks if Remember Me was selected before.
  Future<bool> isRemembered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(StorageKeys.rememberMe) ?? false;
  }

  // Saves Remember Me value.
  Future<void> setRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(StorageKeys.rememberMe, value);
  }

  // Saves the first login date only once.
  // If the date already exists, we return the saved date.
  Future<DateTime> getOrCreateFirstLoginDate() async {
    final prefs = await SharedPreferences.getInstance();
    final savedValue = prefs.getString(StorageKeys.firstLoginDate);

    if (savedValue != null) {
      return DateTime.parse(savedValue);
    }

    final now = DateTime.now();
    await prefs.setString(StorageKeys.firstLoginDate, now.toIso8601String());
    return now;
  }

  // Gets the first login date if it was already saved.
  Future<DateTime?> getFirstLoginDate() async {
    final prefs = await SharedPreferences.getInstance();
    final savedValue = prefs.getString(StorageKeys.firstLoginDate);

    if (savedValue == null) return null;

    return DateTime.parse(savedValue);
  }

  // Clears only login-related saved data.
  Future<void> clearLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(StorageKeys.rememberMe);
  }
}
