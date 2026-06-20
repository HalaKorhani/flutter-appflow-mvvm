import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../utils/network_status_mapper.dart';

// ViewModel responsible for the Network Service screen state.
class NetworkServiceViewModel extends ChangeNotifier {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  String currentStatus = 'Unknown';
  bool serviceRunning = false;
  bool initialized = false;

  Future<void> initialize() async {
    if (initialized) return;
    initialized = true;

    await _loadCurrentNetworkStatus();
  }

  Future<void> _loadCurrentNetworkStatus() async {
    // Reads the current connection type: Wi-Fi, mobile data, or offline.
    final results = await Connectivity().checkConnectivity();

    // Converts ConnectivityResult into user-friendly text.
    currentStatus = NetworkStatusMapper.fromResults(results);

    notifyListeners();
  }
}
