import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pi_papers_2021_2/utils/image_hook.dart';
import 'package:pi_papers_2021_2/utils/picker_hook.dart';

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
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (inputImage.data != null) controller(size, neighbourhoodSize),
              ImageSelector(
                isResult: false,
                image: inputImage.widget,
                onTap: () => usePicker(inputImage),
              ),
              if (outputImage.data != null)
                ImageSelector(
                  isResult: true,
                  image: outputImage.widget,
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  SizedBox controller(Size size, ValueNotifier<int> neighbourhoodSize) {
    return SizedBox(
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
    );
  }
}
