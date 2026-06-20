import 'package:intl/intl.dart';

// Utility class for formatting dates and durations in the app.
class DateTimeUtils {
  // Required first-login format: dd/MM/yyyy HH:mm
  static String formatFirstLogin(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }
}
