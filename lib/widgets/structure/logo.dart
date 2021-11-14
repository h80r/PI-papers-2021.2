import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/style/color_palette.dart';
import 'package:pi_papers_2021_2/widgets/multisize_text.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
    this.isVertical = false,
    required this.title,
  }) : super(key: key);

  final bool isVertical;
  final String title;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      Icons.edit,
      color: ColorPalette.secondary,
      size: isVertical ? 100 : 50,
    );

    return isVertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              MultisizeText(
                text: title,
                smallSize: 70,
                bigSize: 100,
                dividerSize: 40,
                color: ColorPalette.secondary,
              ),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const VerticalDivider(color: Colors.transparent),
              MultisizeText(
                text: title,
                smallSize: 35,
                bigSize: 50,
                dividerSize: 20,
                color: ColorPalette.secondary,
              ),
            ],
          );
  }
}
