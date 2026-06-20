import 'package:flutter_foreground_task/flutter_foreground_task.dart';

// This callback must be top-level and marked as an entry point because Android
// starts it in a separate Dart isolate for the foreground service.
@pragma('vm:entry-point')
void networkMonitorStartCallback() {
  FlutterForegroundTask.setTaskHandler(NetworkMonitorTaskHandler());
}

class NetworkMonitorTaskHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    // The service starts here.
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    // Repeated service work will be added later.
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    // Cleanup code will be added if needed.
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
