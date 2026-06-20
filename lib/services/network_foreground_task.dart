import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import '../utils/network_status_mapper.dart';

// This callback must be top-level and marked as an entry point because Android
// starts it in a separate Dart isolate for the foreground service.
@pragma('vm:entry-point')
void networkMonitorStartCallback() {
  FlutterForegroundTask.setTaskHandler(NetworkMonitorTaskHandler());
}

class NetworkMonitorTaskHandler extends TaskHandler {
  String _lastStatus = 'Unknown';

  Future<void> _checkNetworkAndNotify() async {
    // Check current network connection.
    final results = await Connectivity().checkConnectivity();

    // Convert connection result into readable text.
    final status = NetworkStatusMapper.fromResults(results);

    // Only notify/update when the network status changes.
    if (status != _lastStatus) {
      _lastStatus = status;

      // Update the persistent foreground notification text.
      FlutterForegroundTask.updateService(
        notificationTitle: 'Network Monitor Running',
        notificationText: status,
      );
    }
  }

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    await _checkNetworkAndNotify();
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    _checkNetworkAndNotify();
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    // Nothing to clean up here because we check connectivity periodically.
  }

  @override
  void onReceiveData(Object data) {
    // The UI can send commands here if needed in the future.
  }

  @override
  void onNotificationPressed() {
    // The plugin opens the app when the user taps the foreground notification.
  }
}
