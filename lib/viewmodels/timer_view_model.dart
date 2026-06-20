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

    // Start one timer only. If it already exists, do not create another one.
    _timer ??= Timer.periodic(const Duration(seconds: 1), (_) async {
      _totalSeconds++;
      notifyListeners();

      // Save continuously so the timer survives app restart or sudden close.
      await _repository.saveSeconds(_totalSeconds);
    });
  }

  Future<void> stopAndSave() async {
    // Stop timer before app exit and save latest value.
    _timer?.cancel();
    _timer = null;
    await _repository.saveSeconds(_totalSeconds);
  }

  Future<void> reset() async {
    // Reset timer during logout.
    _timer?.cancel();
    _timer = null;
    _totalSeconds = 0;
    _initialized = false;

    await _repository.clearTimer();
    notifyListeners();
  }

  @override
  void dispose() {
    // Prevent memory leaks when ViewModel is destroyed.
    _timer?.cancel();
    super.dispose();
  }
}
