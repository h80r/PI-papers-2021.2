import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pi_papers_2021_2/algorithm/smoothing_functions.dart';
import 'package:pi_papers_2021_2/models/mask.dart';
import 'package:pi_papers_2021_2/utils/hooks/image_hook.dart';
import 'package:pi_papers_2021_2/utils/hooks/picker_hook.dart';

import 'package:pi_papers_2021_2/widgets/widgets.dart';

class SmoothingPage extends HookWidget {
  const SmoothingPage({Key? key}) : super(key: key);

  final edgeMenu = const {
    'Replicação': replicationSolution,
    'Zero quando Incalculável': zeroSolution,
    'Padding com Zeros': paddingSolution,
    'Convolução Periódica': convolutionSolution,
  };

  @override
  Widget build(BuildContext context) {
    final inputImage = useImage();
    final neighbourhoodSize = useState(3);
    final selectedMask = useState('Simples');
    final edgeSolution = useState<String>(edgeMenu.keys.first);

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
              if (inputImage.data != null)
                SizedBox(
                  width: size.width * 0.25,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 10.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          styledText('Tamanho da vizinhança'),
                          StyledSlider(
                            min: 3,
                            max: 5,
                            value: neighbourhoodSize.value.toDouble(),
                            onChanged: (val) =>
                                neighbourhoodSize.value = val.toInt(),
                            onlyExtremes: true,
                          ),
                          styledText('Tipo de máscara'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: ['Simples', 'Gaussiana']
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: StyledRadio(
                                      value: e,
                                      groupValue: selectedMask.value,
                                      onChanged: (value) =>
                                          selectedMask.value = value!,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          styledText('Estratégia de borda'),
                          StyleDropdown(
                            items: edgeMenu.keys.toList(),
                            value: edgeSolution.value,
                            onChanged: (newValue) =>
                                edgeSolution.value = newValue!,
                          ),
                          const Divider(color: Colors.transparent),
                          FinishButton(
                            text: 'GO',
                            onPressed: () {
                              final mask = selectedMask.value == 'Simples'
                                  ? Mask.simple(neighbourhoodSize.value)
                                  : Mask.gaussian(neighbourhoodSize.value);

                              outputImage.data = operate(
                                inputImage.data,
                                mask,
                                neighbourhoodSize.value,
                                edgeMenu[edgeSolution.value],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
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
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  Widget styledText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
