import 'package:flutter/material.dart';

import '../overlays/login.overlay.dart';

const revexApiUrl = r'localhost:8080';
const revexDefaultHeaders = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
};

class UnauthorizedException implements Exception {}

extension RevExAuthorize<T> on Future<T> Function() {
  Future<T> authorize(BuildContext context) async {
    try {
      return await this();
    } on UnauthorizedException {
      if (context.mounted) {
        await showGeneralDialog(
          context: context,
          pageBuilder: (context, _, __) => const RevExLoginOverlay(),
        );
      }
      return await this();
    }
  }
}
