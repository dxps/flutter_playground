import 'package:flutter/material.dart';
import 'package:flutter_stacked_web_landing/ui/common/app_constants.dart';

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  const InputField({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kdDesktopMaxContentWidth * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(color: const Color(0xFF232323), borderRadius: BorderRadius.circular(8)),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration.collapsed(
          hintText: 'Enter your Email',
          hintStyle: TextStyle(color: Color(0xff989898)),
          filled: true,
          fillColor: Color(0xFF232323),
        ),
      ),
    );
  }
}
