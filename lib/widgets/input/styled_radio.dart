import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/style/color_palette.dart';

class StyledRadio extends StatelessWidget {
  const StyledRadio({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  final String value;
  final String groupValue;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          groupValue: groupValue,
          onChanged: onChanged,
          value: value,
          fillColor: MaterialStateProperty.all(ColorPalette.button),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'SF Pro Display',
            color: ColorPalette.button,
          ),
        )
      ],
    );
  }
}
