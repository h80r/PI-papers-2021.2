import 'package:flutter/material.dart';

class StyledCheckbox extends StatelessWidget {
  const StyledCheckbox({
    Key? key,
    required this.filter,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  final String filter;
  final bool isChecked;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(filter),
      value: isChecked,
      onChanged: onChanged,
    );
  }
}
