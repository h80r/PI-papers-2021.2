import 'package:flutter/material.dart';

class OperationSelection {
  OperationSelection({
    required this.value,
    required this.icon,
    required this.onPressed,
  });

  final String value;
  final IconData icon;
  final void Function() onPressed;
}
