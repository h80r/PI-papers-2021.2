import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/style/color_palette.dart';

class FinishButton extends StatelessWidget {
  const FinishButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: ColorPalette.secondary,
          fontWeight: FontWeight.bold,
          fontFamily: 'SF Pro Display',
          fontSize: 20,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        primary: ColorPalette.primary,
        elevation: 5,
        padding: const EdgeInsets.symmetric(
          horizontal: 120,
          vertical: 20,
        ),
      ),
    );
  }
}
