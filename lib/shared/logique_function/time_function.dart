import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool isStoreOpened(String openAt, String closeAt) {
  // Parse the current time
  DateTime now = DateTime.now();

  // Format to match the input time format (HH:mm:ss)
  DateFormat format = DateFormat("HH:mm:ss");

  // Parse the open and close times, adjusting them to today's date
  DateTime openTime = format.parse(openAt);
  openTime = DateTime(now.year, now.month, now.day, openTime.hour,
      openTime.minute, openTime.second);

  DateTime closeTime = format.parse(closeAt);
  closeTime = DateTime(now.year, now.month, now.day, closeTime.hour,
      closeTime.minute, closeTime.second);

  // Check if the current time is within the range
  return now.isAfter(openTime) && now.isBefore(closeTime);
}

String convertTime(String time) {
  // Parse the input time string
  final parsedTime = TimeOfDay(
    hour: int.parse(time.split(":")[0]),
    minute: int.parse(time.split(":")[1]),
  );
  final isAm = parsedTime.period == DayPeriod.am;
  final arabicPeriod = isAm ? 'ص' : 'م';
  final hourIn12HourFormat =
      parsedTime.hourOfPeriod == 0 ? 12 : parsedTime.hourOfPeriod;
  return '$hourIn12HourFormat$arabicPeriod';
}

TimeOfDay convertStringToTime(String time) {
  final parsedTime = TimeOfDay(
    hour: int.parse(time.split(":")[0]),
    minute: int.parse(time.split(":")[1]),
  );
  return parsedTime;
}

String formatTimeOfDay(TimeOfDay time) {
  final hours = time.hour.toString().padLeft(2, '0');
  final minutes = time.minute.toString().padLeft(2, '0');
  return "$hours:$minutes";
}
 String getTimeFromDate (String date) {
   DateTime dateTime = DateTime.parse(date);
   String formattedTime = DateFormat('HH:mm').format(dateTime);
    return formattedTime;
 }