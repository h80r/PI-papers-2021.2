import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/style/color_palette.dart';

class ImageSelector extends StatelessWidget {
  const ImageSelector({
    Key? key,
    required this.isResult,
    this.image,
    this.message,
    this.onTap,
  })  : assert(
          (!isResult && onTap != null) || isResult,
          'Se a imagem não for um resultado, a função '
          '`onTap` deve ser fornecida',
        ),
        super(key: key);

  final bool isResult;
  final Image? image;
  final String? message;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final smallestSide = MediaQuery.of(context).size.shortestSide;

    return InkWell(
      onTap: isResult ? null : onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: smallestSide * 0.45,
        height: smallestSide * 0.45,
        child: image ??
            Center(
              child: isResult
                  ? Text(
                      message!,
                      style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'SF Pro Display',
                        wordSpacing: 10,
                        letterSpacing: 3,
                        color: ColorPalette.button.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Icon(
                      Icons.add_a_photo_outlined,
                      size: smallestSide * 0.3,
                      color: ColorPalette.button.withOpacity(0.7),
                    ),
            ),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorPalette.button.withOpacity(0.5),
            width: 10,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
