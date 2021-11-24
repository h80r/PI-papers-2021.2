import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/style/color_palette.dart';

class StyleDropdown extends StatefulWidget {
  const StyleDropdown({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<String> items;

  @override
  _StyleDropdownState createState() => _StyleDropdownState();
}

class _StyleDropdownState extends State<StyleDropdown> {
  var value = 'Histograma';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 20,
        ),
        decoration: const ShapeDecoration(
          color: ColorPalette.primary,
          shape: StadiumBorder(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            items: widget.items
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: (newValue) => setState(() => value = newValue!),
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
