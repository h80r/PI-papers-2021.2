import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/style/color_palette.dart';
import 'package:pi_papers_2021_2/widgets/multisize_text.dart';
import 'package:pi_papers_2021_2/widgets/structure/logo.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  const Header({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      automaticallyImplyLeading: false,
      backgroundColor: ColorPalette.primary,
      title: Logo(title: title),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: TextButton.icon(
            onPressed: () => Navigator.of(context).popAndPushNamed('/'),
            icon: const ImageIcon(
              AssetImage("images/prototype/icons/home.png"),
              size: 45,
              color: ColorPalette.background,
            ),
            label: const MultisizeText(
              text: 'Home',
              smallSize: 20,
              bigSize: 30,
              color: ColorPalette.background,
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
