import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/style/color_palette.dart';

class SelectorButton extends StatelessWidget {
  const SelectorButton({
    Key? key,
    required this.groupValue,
    required this.value,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String groupValue;
  final String value;
  final ImageIcon icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final isSelected = groupValue == value;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          child: Padding(padding: const EdgeInsets.all(12), child: icon),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            primary: isSelected ? ColorPalette.hover : ColorPalette.button,
            onPrimary: isSelected ? ColorPalette.button : ColorPalette.hover,
            elevation: 5,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'SF Pro Display',
            color: ColorPalette.primary,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
