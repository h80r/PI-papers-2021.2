import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:pi_papers_2021_2/utils/hooks/image_hook.dart';
import 'package:pi_papers_2021_2/utils/hooks/picker_hook.dart';

import 'package:pi_papers_2021_2/widgets/widgets.dart';

class SpatialFilteringPage extends HookWidget {
  const SpatialFilteringPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputImage = useImage();
    final outputImage = useImage();

    return Scaffold(
      appBar: const Header(title: 'Filtragem Espacial'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ImageSelector(
                  isResult: false,
                  image: inputImage.widget,
                  onTap: () => usePicker(inputImage),
                ),
                ImageSelector(
                  isResult: true,
                  image: outputImage.widget,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
