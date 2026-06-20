import 'package:flutter/material.dart';

import '../repositories/auth_repository.dart';

// ViewModel responsible for login state and authentication logic.
class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repository;

  AuthViewModel(this._repository);

  bool isLoading = true;
  bool isLoggedIn = false;
  bool rememberMe = false;
  String? errorMessage;
  DateTime? firstLoginDate;

  Future<void> initialize() async {
    // Called from SplashScreen to decide whether we skip login.
    isLoading = true;
    notifyListeners();

    // Load Remember Me value from local storage.
    rememberMe = await _repository.isRemembered();

    // If Remember Me is true, user should skip login screen.
    isLoggedIn = rememberMe;

    // Load saved first login date if it exists.
    firstLoginDate = await _repository.getFirstLoginDate();

    isLoading = false;
    notifyListeners();
  }

  Future<bool> login({
    required String username,
    required String password,
    required bool remember,
  }) async {
    // Clear old error before checking login.
    errorMessage = null;
    notifyListeners();

    // Ask repository to validate predefined username/password.
    final valid = _repository.validateLogin(username, password);

    if (!valid) {
      errorMessage = 'Invalid username or password';
      notifyListeners();
      return false;
    }

    // Save or load the first login date.
    firstLoginDate = await _repository.getOrCreateFirstLoginDate();

    // Update login state.
    rememberMe = remember;
    isLoggedIn = true;

    // Save Remember Me choice.
    // If remember is false, user can enter now,
    // but next app launch will show login again.
    await _repository.setRememberMe(remember);

    notifyListeners();
    return true;
  }

  void clearError() {
    // Used if we want to remove the login error from the UI.
    errorMessage = null;
    notifyListeners();
  }

  Future<void> logoutStateOnly() async {
    // Reset ViewModel state after saved values are cleared by AppResetRepository.
    isLoggedIn = false;
    rememberMe = false;
    firstLoginDate = null;
    errorMessage = null;
    notifyListeners();
  }
}
