import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/style/color_palette.dart';

class StyledSlider extends StatelessWidget {
  const StyledSlider({
    Key? key,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final double min;
  final double max;
  final double value;
  final void Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [min, max]
                .map(
                  (e) => Text(
                    e.toString(),
                    style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: ColorPalette.button,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            valueIndicatorColor: ColorPalette.button,
            thumbColor: ColorPalette.button,
            activeTrackColor: ColorPalette.button,
            inactiveTrackColor: ColorPalette.button,
          ),
          child: Slider(
            min: min,
            max: max,
            value: value,
            divisions: (max + min.abs()).toInt(),
            onChanged: onChanged,
            label: value.toStringAsFixed(1),
          ),
        ),
      ],
    );
  }
}
