import 'package:flutter/material.dart';

class ModalData {
  const ModalData({
    required this.id,
    this.type,
    required this.title,
    required this.offset,
    required this.size,
    required this.child,
  });

  final int id;
  final String? type;
  final String title;
  final Offset offset;
  final Size size;
  final Widget child;

  ModalData copyWith({String? type, String? title, Offset? offset, Size? size, Widget? child}) {
    return ModalData(
      id: id,
      type: type ?? this.type,
      title: title ?? this.title,
      offset: offset ?? this.offset,
      size: size ?? this.size,
      child: child ?? this.child,
    );
  }
}
