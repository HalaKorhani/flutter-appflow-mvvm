import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/date_time_utils.dart';
import '../viewmodels/auth_view_model.dart';
import '../viewmodels/timer_view_model.dart';

// Screen responsible for showing total time spent in the app.
class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final timerViewModel = context.watch<TimerViewModel>();
    final authViewModel = context.watch<AuthViewModel>();
    final firstLoginDate = authViewModel.firstLoginDate;

    return Stack(
      children: [
        if (firstLoginDate != null)
          Positioned(
            top: 14,
            right: 14,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  'First login:\n${DateTimeUtils.formatFirstLogin(firstLoginDate)}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.timer, size: 80, color: Colors.deepPurple),
              const SizedBox(height: 24),
              Text(
                timerViewModel.formattedTime,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text('Total time spent in the app'),
            ],
          ),
        ),
      ],
    );
  }
}
