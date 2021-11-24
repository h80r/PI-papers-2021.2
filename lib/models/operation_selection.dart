import 'package:flutter/material.dart';

class OperationSelection {
  OperationSelection({
    required this.value,
    required this.icon,
    required this.onPressed,
  });

  final String value;
  final ImageIcon icon;
  final void Function() onPressed;
}
