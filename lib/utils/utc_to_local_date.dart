import 'package:intl/intl.dart';

String formatUtcToLocalDate(String utcTimestamp) {
  DateTime utcTime = DateTime.parse(utcTimestamp).toUtc();
  DateTime localTime = utcTime.toLocal();
  return DateFormat('dd MMM yyyy').format(localTime);
}
