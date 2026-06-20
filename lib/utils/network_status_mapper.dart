import 'package:connectivity_plus/connectivity_plus.dart';

// Converts ConnectivityResult values into the user-friendly text required by the assignment.
class NetworkStatusMapper {
  static String fromResults(List<ConnectivityResult> results) {
    if (results.isEmpty || results.contains(ConnectivityResult.none)) {
      return 'No Internet Connection';
    }

    if (results.contains(ConnectivityResult.wifi)) {
      return 'Connected to Wi-Fi';
    }

    if (results.contains(ConnectivityResult.mobile)) {
      return 'Switched to Mobile Data';
    }

    if (results.contains(ConnectivityResult.ethernet)) {
      return 'Connected to Ethernet';
    }

    return 'Connected';
  }
}
