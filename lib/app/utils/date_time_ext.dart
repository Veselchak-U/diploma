import 'package:json_annotation/json_annotation.dart';

extension DateTimeExt on DateTime {
  bool operator <=(DateTime other) {
    return isBefore(other) || isAtSameMomentAs(other);
  }

  bool operator >=(DateTime other) {
    return isAfter(other) || isAtSameMomentAs(other);
  }

  bool isOnTheSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isBeforeToday() {
    final now = DateTime.now();
    return isBefore(DateTime(now.year, now.month, now.day));
  }

  bool isBeforeTomorrow() {
    final now = DateTime.now();
    return isBefore(DateTime(now.year, now.month, now.day + 1));
  }

  String get serverFormat => const ConvertDateTime().toJson(this);

  int get millisecondsFromStartOfDay =>
      difference(DateTime(year, month, day)).inMilliseconds;

  DateTime get endOfDay => DateTime(year, month, day, 24);
}

class ConvertDateTime implements JsonConverter<DateTime, String> {
  const ConvertDateTime();

  @override
  DateTime fromJson(String value) {
    return DateTime.parse(value).toLocal();
  }

  @override
  String toJson(DateTime value) {
    return value.toUtc().toIso8601String();
  }
}
