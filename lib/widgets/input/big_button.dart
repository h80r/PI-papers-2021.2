import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/style/color_palette.dart';
import 'package:pi_papers_2021_2/widgets/multisize_text.dart';

class BigButton extends StatelessWidget {
  const BigButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: ColorPalette.secondary,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 40,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: text
            .split(' ')
            .map(
              (e) => MultisizeText(
                text: e,
                smallSize: 21,
                bigSize: 30,
                color: ColorPalette.background,
              ),
            )
            .toList(),
      ),
    );
  }
}
