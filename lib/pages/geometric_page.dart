import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:pi_papers_2021_2/models/operation_selection.dart';

import 'package:pi_papers_2021_2/style/color_palette.dart';

import 'package:pi_papers_2021_2/utils/hooks/image_hook.dart';
import 'package:pi_papers_2021_2/utils/hooks/picker_hook.dart';
import 'package:pi_papers_2021_2/utils/web_utils.dart';

import 'package:pi_papers_2021_2/widgets/widgets.dart';

import 'package:pi_papers_2021_2/algorithm/geometric_functions.dart';

class GeometricPage extends HookWidget {
  const GeometricPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageA = useImage();
    final imageB = useImage();
    final operation = useState<GeometricFunction?>(null);

    final selectedRadio = useState('Horizontal');
    final selectedSlider = useState(0.0);
    final selectedSlider2 = useState(0.0);
    final isLoading = useState(false);

    return Scaffold(
      appBar: const Header(
        title: 'Transformações Geométricas',
      ),
      body: isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (operation.value != null)
                        Column(
                          children: [
                            operationControllers(
                              operation: operation,
                              selectedSlider: selectedSlider,
                              selectedSlider2: selectedSlider2,
                              selectedRadio: selectedRadio,
                            ),
                            FinishButton(
                              text: 'Transformar',
                              onPressed: () async {
                                isLoading.value = true;

                                await Future.delayed(
                                  const Duration(seconds: 2),
                                );

                                imageB.data = operate(
                                  image: imageA.data,
                                  inputs: {
                                    'moveX': selectedSlider.value.toInt(),
                                    'moveY': selectedSlider2.value.toInt(),
                                    'reflectionType': {
                                          'Horizontal': 1,
                                          'Vertical': 2,
                                        }[selectedRadio.value] ??
                                        0,
                                    'rotation': selectedSlider.value.toInt(),
                                    'scale':
                                        (selectedSlider.value * 10).toInt(),
                                  },
                                  operation: operation.value,
                                );

                                isLoading.value = false;

                                operation.value = null;
                              },
                            ),
                          ],
                        ),
                      ImageSelector(
                        isResult: false,
                        image: imageA.widget,
                        onTap: () => usePicker(imageA),
                      ),
                      ImageSelector(
                        isResult: true,
                        image: imageB.widget,
                        message: imageB.message,
                      ),
                    ],
                  ),
                  Selector(
                    options: [
                      OperationSelection(
                        value: 'Translação',
                        icon: ImageIcon(
                          AssetImage(
                              path('images/prototype/icons/translation.png')),
                        ),
                        onPressed: () {
                          selectedSlider.value = 0.0;
                          selectedSlider2.value = 0.0;
                          operation.value = translation;
                        },
                      ),
                      OperationSelection(
                        value: 'Rotação',
                        icon: ImageIcon(
                          AssetImage(
                              path('images/prototype/icons/rotation.png')),
                        ),
                        onPressed: () => operation.value = rotation,
                      ),
                      OperationSelection(
                        value: 'Escala',
                        icon: ImageIcon(
                          AssetImage(path('images/prototype/icons/scale.png')),
                        ),
                        onPressed: () {
                          selectedSlider.value = 1.0;
                          operation.value = scale;
                        },
                      ),
                      OperationSelection(
                        value: 'Reflexão',
                        icon: ImageIcon(
                          AssetImage(
                            path('images/prototype/icons/reflection.png'),
                          ),
                        ),
                        onPressed: () => operation.value = reflection,
                      ),
                    ],
                  ),
                ],
              ),
            ),
      bottomNavigationBar: const Footer(),
    );
  }

  SizedBox operationControllers({
    required ValueNotifier<GeometricFunction?> operation,
    required ValueNotifier<double> selectedSlider,
    required ValueNotifier<double> selectedSlider2,
    required ValueNotifier<String> selectedRadio,
  }) {
    final reflectionValues = ['Horizontal', 'Vertical', 'Ambos'];
    final sliderMinValues = {scale: 0.5, rotation: -180.0, translation: -50.0};
    final sliderMaxValues = {scale: 2.0, rotation: 180.0, translation: 50.0};

    return SizedBox(
      width: 400,
      child: Column(
        children: [
          if (operation.value != reflection)
            Row(
              children: [
                if (operation.value == translation)
                  const Expanded(
                    flex: 3,
                    child: Text(
                      'Horizontal',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'SF Pro Display',
                        color: ColorPalette.button,
                      ),
                    ),
                  ),
                Expanded(
                  flex: 7,
                  child: StyledSlider(
                    min: sliderMinValues[operation.value]!,
                    max: sliderMaxValues[operation.value]!,
                    value: selectedSlider.value,
                    isDecimal: operation.value == scale,
                    onChanged: (value) => selectedSlider.value = value,
                  ),
                ),
              ],
            ),
          if (operation.value == translation)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 3,
                  child: Text(
                    'Vertical',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'SF Pro Display',
                      color: ColorPalette.button,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: StyledSlider(
                    min: -50,
                    max: 50,
                    value: selectedSlider2.value,
                    onChanged: (value) => selectedSlider2.value = value,
                  ),
                ),
              ],
            ),
          if (operation.value == reflection)
            Row(
              children: reflectionValues
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: StyledRadio(
                        value: e,
                        groupValue: selectedRadio.value,
                        onChanged: (value) => selectedRadio.value = value!,
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
