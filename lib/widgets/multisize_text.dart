import 'package:flutter/material.dart';

class MultisizeText extends StatelessWidget {
  const MultisizeText({
    Key? key,
    required this.text,
    required this.smallSize,
    required this.bigSize,
    required this.dividerSize,
    required this.color,
  }) : super(key: key);

  final String text;
  final double smallSize;
  final double bigSize;
  final double dividerSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: text.toUpperCase().replaceAll(' ', '   ').split(' ').map(
          (word) {
            var counter = 0;

            return TextSpan(
              children: word.split('').map((letter) {
                return TextSpan(
                  text: letter,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: letter == ' '
                        ? dividerSize
                        : counter++ == 0
                            ? bigSize
                            : smallSize,
                    color: color,
                  ),
                );
              }).toList(),
            );
          },
        ).toList(),
      ),
    );
  }
}
