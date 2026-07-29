//library date_extensions;

/// This will be helpful for the liturgical engine.
/// No liturgical knowledge is needed to understand this code,
/// it is just a simple extension to the DateTime class in Dart.
/// This helps to get the date only from a DateTime object, ignoring the time part.
extension DateOnly on DateTime {
  // Removing the time part of the DateTime object and
  /// Canonicalizes to a UTC date with no time component. ALWAYS use this
  /// when a DateTime enters the engine from the outside (user input,
  /// DateTime.now(), etc.) — the rest of the engine assumes date-only values
  /// and will misbehave on decorated DateTimes
  DateTime get dateOnly => DateTime.utc(year, month, day);

  bool get isSunday => weekday == DateTime.sunday;
  bool get isSaturday => weekday == DateTime.saturday;

  /// Returns true if the date is the same as the other date, ignoring the time part.
  bool isSameDateAs(DateTime other) {
    final a = dateOnly;
    final b = other.dateOnly;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
  /// Returns true if the date is within the range of start and end dates, ignoring the time part.
  bool isWithin(DateTime start, DateTime end) {
    final d = dateOnly;
    final s = start.dateOnly;
    final e = end.dateOnly;
    return !d.isBefore(s) && !d.isAfter(e);
  }
}
