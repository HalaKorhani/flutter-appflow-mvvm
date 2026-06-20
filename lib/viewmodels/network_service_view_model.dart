import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

// ViewModel responsible for the Network Service screen state.
class NetworkServiceViewModel extends ChangeNotifier {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  String currentStatus = 'Unknown';
  bool serviceRunning = false;
  bool initialized = false;
}
