import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/style/color_palette.dart';
import 'package:pi_papers_2021_2/widgets/input/big_button.dart';
import 'package:pi_papers_2021_2/widgets/structure/footer.dart';
import 'package:pi_papers_2021_2/widgets/structure/logo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Logo(
              title: 'Dr. Image',
              isVertical: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BigButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/arithmetic_operation'),
                  text: 'Operações Aritméticas',
                ),
                const VerticalDivider(
                  color: Colors.transparent,
                  width: 30,
                ),
                BigButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed('/geometric_transformation'),
                  text: 'Transformações Geométricas',
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
