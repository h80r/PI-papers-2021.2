import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/style/color_palette.dart';
import 'package:pi_papers_2021_2/widgets/multisize_text.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: ColorPalette.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            'Guilherme Brandt',
            'Heitor Galdino',
            'Hernandes Macedo',
            'Thaís Calixto',
          ]
              .map((e) => MultisizeText(
                    text: e,
                    smallSize: 20,
                    bigSize: 30,
                    dividerSize: 20,
                    color: ColorPalette.background,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
