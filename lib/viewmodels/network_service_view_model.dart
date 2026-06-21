import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import '../services/network_foreground_task.dart';
import '../utils/network_status_mapper.dart';

class NetworkServiceViewModel extends ChangeNotifier {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  String currentStatus = 'Unknown';
  bool serviceRunning = false;
  bool initialized = false;

  Future<void> initialize() async {
    if (initialized) return;
    initialized = true;

    // Receives messages sent by NetworkMonitorTaskHandler in the service isolate.
    FlutterForegroundTask.addTaskDataCallback(_onTaskDataReceived);

    _initializeForegroundTaskSettings();
    await _loadCurrentNetworkStatus();
    await refreshServiceStatus();

    // This keeps the screen updated while the app is open.
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) {
      currentStatus = NetworkStatusMapper.fromResults(results);
      notifyListeners();
    });
  }

  void _onTaskDataReceived(Object data) {
    if (data is String) {
      currentStatus = data;
      notifyListeners();
    }
  }

  void _initializeForegroundTaskSettings() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'network_monitor_channel',
        channelName: 'Network Monitor',
        channelDescription: 'Shows network status while monitoring is active.',
        onlyAlertOnce: false,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: false,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        // The service checks network status every 5 seconds.
        eventAction: ForegroundTaskEventAction.repeat(5000),
        autoRunOnBoot: false,
        autoRunOnMyPackageReplaced: false,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  Future<void> _loadCurrentNetworkStatus() async {
    final results = await Connectivity().checkConnectivity();
    currentStatus = NetworkStatusMapper.fromResults(results);
    notifyListeners();
  }

  Future<void> requestForegroundPermissions() async {
    // Android 13+ requires runtime notification permission.
    final notificationPermission =
        await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    if (Platform.isAndroid) {
      // Helps the foreground service survive longer on Android devices.
      if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
        await FlutterForegroundTask.requestIgnoreBatteryOptimization();
      }
    }
  }

  Future<void> startService() async {
    await requestForegroundPermissions();

    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.restartService();
    } else {
      await FlutterForegroundTask.startService(
        serviceId: 100,
        notificationTitle: 'Network Monitor Running',
        notificationText: currentStatus,
        callback: networkMonitorStartCallback,
      );
    }

    await refreshServiceStatus();
  }

  Future<void> stopService() async {
    await FlutterForegroundTask.stopService();
    await refreshServiceStatus();
  }

  Future<void> refreshServiceStatus() async {
    serviceRunning = await FlutterForegroundTask.isRunningService;
    notifyListeners();
  }

  Future<void> reset() async {
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.stopService();
    }
    currentStatus = 'Unknown';
    serviceRunning = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    FlutterForegroundTask.removeTaskDataCallback(_onTaskDataReceived);
    super.dispose();
  }
}
