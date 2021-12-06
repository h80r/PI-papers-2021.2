import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pi_papers_2021_2/utils/image_hook.dart';

import 'package:pi_papers_2021_2/widgets/widgets.dart';

class SmoothingPage extends HookWidget {
  const SmoothingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputImage = useImage();
    final neighbourhoodSize = useState(3);

    final outputImage = useImage();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const Header(title: 'Filtro Smoothing'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: size.width * 0.25,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StyledSlider(
                      min: 3,
                      max: 5,
                      value: neighbourhoodSize.value.toDouble(),
                      onChanged: (val) => neighbourhoodSize.value = val.toInt(),
                      onlyExtremes: true,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
