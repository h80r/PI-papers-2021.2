import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/style/color_palette.dart';

class StyleDropdown extends StatelessWidget {
  const StyleDropdown({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final List<String> items;
  final String value;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      decoration: const ShapeDecoration(
        color: ColorPalette.primary,
        shape: StadiumBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: SizedBox(
          width: 350,
          child: DropdownButton<String>(
            value: value,
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: onChanged,
            borderRadius: const BorderRadius.all(Radius.circular(40.0)),
            elevation: 5,
            isDense: true,
            dropdownColor: ColorPalette.primary,
            style: const TextStyle(
              color: ColorPalette.secondary,
              fontWeight: FontWeight.bold,
              fontFamily: 'SF Pro Display',
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
