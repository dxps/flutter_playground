import 'package:flutter/material.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';

import '../../utils/format_date.dart';

class MonthPickerButton extends StatelessWidget {
  final DateTime date;
  final Set<DateTime> months;
  final Function(DateTime) onMonthSelected;

  const MonthPickerButton({super.key, required this.date, required this.months, required this.onMonthSelected});

  @override
  Widget build(BuildContext context) {
    var minMonth = months.reduce((a, b) => a.isBefore(b) ? a : b);
    var maxMonth = months.reduce((a, b) => a.isAfter(b) ? a : b);

    return ElevatedButton(
      onPressed: () {
        showMonthPicker(
          context,
          firstYear: minMonth.year,
          lastYear: maxMonth.year,
          firstEnabledMonth: minMonth.month,
          lastEnabledMonth: maxMonth.month,
          initialSelectedMonth: date.month,
          initialSelectedYear: date.year,
          highlightColor: Colors.grey,
          textColor: Colors.black,
          onSelected: (month, year) => onMonthSelected(DateTime(year, month)),
        );
      },
      child: Text(
        "Selected month: ${formatDate(date)}",
        style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }
}
