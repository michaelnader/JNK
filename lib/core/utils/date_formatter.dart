import 'package:intl/intl.dart';

/// Centralised date formatters so the booking flow, history list, and event
/// feed all read with one voice.
class AppDateFormat {
  const AppDateFormat._();

  static final _full = DateFormat('EEE d MMM · h:mm a');
  static final _short = DateFormat('d MMM');
  static final _shortDateTime = DateFormat('d MMM · h:mm a');
  static final _dayMonth = DateFormat('EEE, MMM d');
  static final _time = DateFormat('h:mm a');

  static String full(DateTime dt) => _full.format(dt);
  static String short(DateTime dt) => _short.format(dt);
  static String shortDateTime(DateTime dt) => _shortDateTime.format(dt);
  static String dayMonth(DateTime dt) => _dayMonth.format(dt);
  static String time(DateTime dt) => _time.format(dt);

  /// "In 3 days", "Tonight", "Yesterday" etc. Bounded to ±30 days; otherwise
  /// falls back to the long format.
  static String relative(DateTime dt, {DateTime? now}) {
    final n = now ?? DateTime.now();
    final today = DateTime(n.year, n.month, n.day);
    final target = DateTime(dt.year, dt.month, dt.day);
    final diff = target.difference(today).inDays;

    if (diff == 0) return 'Tonight · ${_time.format(dt)}';
    if (diff == 1) return 'Tomorrow · ${_time.format(dt)}';
    if (diff == -1) return 'Yesterday';
    if (diff > 1 && diff <= 7) return 'In $diff days · ${_time.format(dt)}';
    if (diff < -1 && diff >= -7) return '${diff.abs()} days ago';
    if (diff > 7 && diff <= 30) return _dayMonth.format(dt);
    return _full.format(dt);
  }
}
