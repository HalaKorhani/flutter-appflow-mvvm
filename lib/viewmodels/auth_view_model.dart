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
}
