import 'dart:math';

import 'package:flutter/material.dart';

class RevExSortIcon extends StatefulWidget {
  final bool isAscending;

  const RevExSortIcon({
    super.key,
    required this.isAscending,
  });

  @override
  State<RevExSortIcon> createState() => _RevExSortIconState();
}

class _RevExSortIconState extends State<RevExSortIcon>
    with SingleTickerProviderStateMixin {
  late bool isAscendingCached;
  late final AnimationController controller;
  late final Animation<double> ascendAnimation;
  late final Animation<double> descendAnimation;
  late final Animation<double> rotateAnimation;

  @override
  void initState() {
    super.initState();

    isAscendingCached = widget.isAscending;

    controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..value = 1.0;

    controller.addListener(() {
      setState(() {});
    });

    final ascendTween = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(
        tween: Tween<double>(
          begin: -1,
          end: 0,
        ).chain(
          CurveTween(curve: Curves.easeOut),
        ),
        weight: 0.3,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(0),
        weight: 0.4,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0,
          end: 1,
        ).chain(
          CurveTween(curve: Curves.easeOut),
        ),
        weight: 0.3,
      ),
    ]);

    ascendAnimation = controller.drive(ascendTween);

    final descendTween = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1,
          end: 0,
        ).chain(
          CurveTween(curve: Curves.easeOut),
        ),
        weight: 0.3,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(0),
        weight: 0.4,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0,
          end: -1,
        ).chain(
          CurveTween(curve: Curves.easeOut),
        ),
        weight: 0.3,
      ),
    ]);

    descendAnimation = controller.drive(descendTween);

    final rotateInterval = CurveTween(
      curve: const Interval(
        0.33,
        0.66,
        curve: Curves.easeOut,
      ),
    );

    final rotateTween = Tween<double>(begin: 0, end: pi * 2);

    rotateAnimation = controller.drive(rotateInterval).drive(rotateTween);
  }

  @override
  void didUpdateWidget(RevExSortIcon oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAscending != isAscendingCached) {
      isAscendingCached = widget.isAscending;
      controller.reset();
      controller.forward();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotateAnimation.value,
      child: CustomPaint(
        painter: _SortIconPainter(
          ascendingness: isAscendingCached
              ? ascendAnimation.value
              : descendAnimation.value,
        ),
        size: const Size(16, 16),
      ),
    );
  }
}

class _SortIconPainter extends CustomPainter {
  final double ascendingness;

  _SortIconPainter({required this.ascendingness});

  @override
  void paint(Canvas canvas, Size size) {
    const baseline = 0.5;
    const extent = 0.2;
    final startY = (ascendingness * extent) + baseline;
    final midY = (-1 * ascendingness * extent) + baseline;

    final chevronPoints = [
      [0.1, startY],
      [0.5, midY],
      [0.9, startY],
    ];

    var path = Path();

    path.moveTo(
        size.width * chevronPoints[0][0], size.height * chevronPoints[0][1]);
    path.lineTo(
        size.width * chevronPoints[1][0], size.height * chevronPoints[1][1]);
    path.lineTo(
        size.width * chevronPoints[2][0], size.height * chevronPoints[2][1]);

    var paint = Paint();
    paint.color = Colors.black;
    paint.strokeWidth = 1.5;
    paint.style = PaintingStyle.stroke;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_SortIconPainter oldDelegate) => true;
}
