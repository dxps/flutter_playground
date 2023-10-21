import 'package:flutter/material.dart';

class HomeNotifyButton extends StatelessWidget {
  final Function()? onTap;
  const HomeNotifyButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We're adding a Gesture detector now so we don't need to later
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Notify Me',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
    );
  }
}
