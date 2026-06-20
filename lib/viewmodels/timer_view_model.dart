import 'dart:async';

import 'package:flutter/material.dart';

import '../repositories/timer_repository.dart';
import '../utils/date_time_utils.dart';

// ViewModel responsible for timer state and timer logic.
class TimerViewModel extends ChangeNotifier {
  final TimerRepository _repository;

  TimerViewModel(this._repository);

  Timer? _timer;
  int _totalSeconds = 0;
  bool _initialized = false;

  int get totalSeconds => _totalSeconds;
  String get formattedTime => DateTimeUtils.formatDuration(_totalSeconds);

  Future<void> initializeAndStart() async {
    // Load saved timer seconds only once.
    // This prevents timer reset when navigating between screens.
    if (!_initialized) {
      _totalSeconds = await _repository.loadSeconds();
      _initialized = true;
      notifyListeners();
    }
  }
}
