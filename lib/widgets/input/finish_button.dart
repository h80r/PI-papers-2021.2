import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/style/color_palette.dart';

class FinishButton extends StatelessWidget {
  const FinishButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isCompact = false,
  }) : super(key: key);

  final String text;
  final void Function() onPressed;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: isCompact ? ColorPalette.primary : ColorPalette.secondary,
          fontWeight: FontWeight.bold,
          fontFamily: 'SF Pro Display',
          fontSize: 20,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: isCompact ? const CircleBorder() : const StadiumBorder(),
        primary: isCompact ? ColorPalette.secondary : ColorPalette.primary,
        elevation: 5,
        padding: EdgeInsets.symmetric(
          horizontal: isCompact ? 35 : 120,
          vertical: 20,
        ),
      ),
    );
  }
}
