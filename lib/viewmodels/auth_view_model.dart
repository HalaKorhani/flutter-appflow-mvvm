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
}
