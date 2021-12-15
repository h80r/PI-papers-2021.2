import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/style/color_palette.dart';

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
    return Theme(
      data: ThemeData(unselectedWidgetColor: ColorPalette.hover),
      child: CheckboxListTile(
        title: Text(
          filter,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'SF Pro Display',
            color: ColorPalette.hover,
          ),
        ),
        value: isChecked,
        onChanged: onChanged,
        activeColor: ColorPalette.hover,
        checkColor: ColorPalette.background,
      ),
    );
  }
}
