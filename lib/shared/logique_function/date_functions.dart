import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String combineDateTimeAndTimeOfDay(
    DateTime date, TimeOfDay time, String? type) {
  final combinedDateTime = DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
    type == 'end' ? 59 : 0,
  );

  final formattedDate =
      DateFormat('yyyy-MM-dd HH:mm:ss').format(combinedDateTime);
  return formattedDate;
}

String convertToArabicDate(String isoDate) {
  DateTime date = DateTime.parse(isoDate);
  final DateFormat monthFormatter = DateFormat("MMMM", "ar");
  String arabicMonth = monthFormatter.format(date);
  String formattedDate = "${date.day} $arabicMonth ${date.year}";
  return formattedDate;
}

String getTomorrowDate() {
  final tomorrow = DateTime.now().add(const Duration(days: 1));
  return convertToArabicDate(tomorrow.toString());
}
