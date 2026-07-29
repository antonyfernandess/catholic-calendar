
import 'package:breviary/modules/liturgical_calendar/core/algorithms/date_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('dateOnly', () {
    test('strips time component', () {
      final d = DateTime(2026, 7, 23, 14, 30, 15);
      expect(d.dateOnly, DateTime.utc(2026, 7, 23));
    });
  });

  group('sundayOnOrBefore', () {
    test('Sunday itself returns itself', () {
      final sunday = DateTime.utc(2026, 7, 19); // known Sunday
      expect(sunday.sundayOnOrBefore, sunday);
    });
    test('Wednesday returns the preceding Sunday', () {
      final wed = DateTime.utc(2026, 7, 22);
      expect(wed.sundayOnOrBefore, DateTime.utc(2026, 7, 19));
    });
    test('Monday returns the immediately preceding Sunday', () {
      final mon = DateTime.utc(2026, 7, 20);
      expect(mon.sundayOnOrBefore, DateTime.utc(2026, 7, 19));
    });
  });

  group('sundayOnOrAfter', () {
    test('Sunday itself returns itself', () {
      final sunday = DateTime.utc(2026, 7, 19);
      expect(sunday.sundayOnOrAfter, sunday);
    });
    test('Monday returns the next Sunday (6 days later)', () {
      final mon = DateTime.utc(2026, 7, 20);
      expect(mon.sundayOnOrAfter, DateTime.utc(2026, 7, 26));
    });
  });

  group('isWithin', () {
    test('boundary dates are inclusive', () {
      final start = DateTime.utc(2026, 3, 1);
      final end = DateTime.utc(2026, 3, 31);
      expect(start.isWithin(start, end), isTrue);
      expect(end.isWithin(start, end), isTrue);
      expect(DateTime.utc(2026, 2, 28).isWithin(start, end), isFalse);
      expect(DateTime.utc(2026, 4, 1).isWithin(start, end), isFalse);
    });
  });

  group('nthWeekdayOnOrAfter', () {
    test('1st Sunday on/after a Sunday is itself', () {
      final sunday = DateTime.utc(2026, 7, 19);
      expect(sunday.nthWeekdayOnOrAfter(DateTime.sunday, 1), sunday);
    });
    test('3rd Thursday on/after a given Monday', () {
      final mon = DateTime.utc(2026, 7, 20);
      // Thursdays on/after: Jul 23, Jul 30, Aug 6 -> 3rd is Aug 6
      expect(mon.nthWeekdayOnOrAfter(DateTime.thursday, 3), DateTime.utc(2026, 8, 6));
    });
  });

  group('daysUntil', () {
    test('positive when other is later', () {
      final a = DateTime.utc(2026, 1, 1);
      final b = DateTime.utc(2026, 1, 10);
      expect(a.daysUntil(b), 9);
      expect(b.daysUntil(a), -9);
    });
  });
}