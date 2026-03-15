import 'package:flutter/material.dart';

import 'activity_details_card.dart';
import 'header_widget.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 18),
        HeaderWidget(),
        SizedBox(height: 18),
        ActivityDetailsCard(),
        SizedBox(height: 18),
      ],
    );
  }
}
