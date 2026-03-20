import 'package:flutter/material.dart';
import 'package:responsive_fitness/widgets/activity_details_card.dart';
import 'package:responsive_fitness/widgets/bar_graph_card_widget.dart';
import 'package:responsive_fitness/widgets/header_widget.dart';
import 'package:responsive_fitness/widgets/line_chart_card.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: const Column(
          children: [
            SizedBox(height: 18),
            HeaderWidget(),
            SizedBox(height: 18),
            ActivityDetailsCard(),
            SizedBox(height: 18),
            LineChartCard(),
            SizedBox(height: 18),
            BarGraphCard(),
            SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
