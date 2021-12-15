import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:pi_papers_2021_2/utils/hooks/image_hook.dart';
import 'package:pi_papers_2021_2/utils/hooks/picker_hook.dart';

import 'package:pi_papers_2021_2/style/color_palette.dart';

import 'package:pi_papers_2021_2/widgets/widgets.dart';
import 'package:pi_papers_2021_2/widgets/input/styled_checkbox.dart';

import 'package:pi_papers_2021_2/algorithm/spatial_functions.dart';

class SpatialFilteringPage extends HookWidget {
  const SpatialFilteringPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputImage = useImage();
    final outputImage = useImage();
    final sigmaValue = useState(1.4);

    final allFilters = useState({
      "Laplaciano": false,
      "Sharpening": false,
      "Laplaciano do Gaussiano": false,
      "Unsharp Masking": false,
      "Highboost Filtering": false,
      "Gradiente": false,
      "Detector de Roberts/Sobel": false,
    });

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
                Column(
                  children: [
                    operationControllers(
                      allFilters: allFilters,
                    ),
                  ],
                ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Padding(padding: EdgeInsets.all(16.0)),
                    if (allFilters.value["Laplaciano do Gaussiano"] == true)
                      const Text(
                        'Valor de Sigma',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'SF Pro Display',
                          color: ColorPalette.button,
                        ),
                      ),
                    if (allFilters.value["Laplaciano do Gaussiano"] == true)
                      SizedBox(
                        width: 400,
                        child: StyledSlider(
                          min: 0.5,
                          max: 2,
                          value: sigmaValue.value.toDouble(),
                          onChanged: (value) => sigmaValue.value = value,
                          isDecimal: true,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: FinishButton(
                    text: 'GO',
                    onPressed: () {
                      outputImage.data = operate(
                        inputImage.data,
                        allFilters.value,
                        sigmaValue.value,
                      );
                    },
                  ),
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
    required ValueNotifier<Map> allFilters,
  }) {
    return SizedBox(
      width: 400,
      child: Column(
        children: allFilters.value.keys
            .map(
              (filter) => StyledCheckbox(
                filter: filter,
                isChecked: allFilters.value[filter],
                onChanged: (_) {
                  var copy = Map<String, bool>.from(allFilters.value);
                  copy.update(filter, (value) => !value);
                  allFilters.value = copy;
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
