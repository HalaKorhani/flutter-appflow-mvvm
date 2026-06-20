import 'package:intl/intl.dart';

// Utility class for formatting dates and durations in the app.
class DateTimeUtils {
  // Required first-login format: dd/MM/yyyy HH:mm
  static String formatFirstLogin(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  // Converts total seconds to hh:mm:ss.
  static String formatDuration(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    String twoDigits(int value) => value.toString().padLeft(2, '0');

    return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
  }
}
