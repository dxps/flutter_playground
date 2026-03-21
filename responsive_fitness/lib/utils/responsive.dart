import 'package:flutter/material.dart';

/// Utility class for responsive design.
/// - Mobile: width < 850
/// - Tablet: 850 <= width < 1100
/// - Desktop: width >= 1100
class Responsive {
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width < 1100 && size.width >= 850;
  }

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;
}
