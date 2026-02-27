import 'package:shared_preferences/shared_preferences.dart';

const _dateKey = 'FIRST_USAGE_DATE';
Future<DateTime> revexGetFirstUsageDate() async {
  final prefs = await SharedPreferences.getInstance();
  final now = DateTime.now();

  if (!prefs.containsKey(_dateKey) || prefs.get(_dateKey) == null) {
    await revexSetFirstUsageDate(now);
    return now;
  }

  final storedUsageDate = prefs.getString(_dateKey)!;
  return DateTime.parse(storedUsageDate);
}

Future revexSetFirstUsageDate(DateTime date) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_dateKey, date.toIso8601String());
}
