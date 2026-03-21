import 'package:flutter/material.dart';
import 'package:responsive_fitness/utils/consts.dart';

import '../utils/responsive.dart';
import 'pie_chart_widget.dart';
import 'scheduled_widget.dart';
import 'summary_details.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: backgroundColor),
      child: Padding(
        padding: EdgeInsets.only(left: (Responsive.isMobile(context) ? 20.0 : 0), top: 20.0, right: 20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Chart(),
            Text('Summary', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 16),
            SummaryDetails(),
            SizedBox(height: 40),
            Scheduled(),
          ],
        ),
      ),
    );
  }
}
