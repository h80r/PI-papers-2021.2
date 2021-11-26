import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pi_papers_2021_2/models/operation_selection.dart';

import 'package:pi_papers_2021_2/style/color_palette.dart';
import 'package:pi_papers_2021_2/utils/web_utils.dart';

import 'package:pi_papers_2021_2/widgets/input/finish_button.dart';
import 'package:pi_papers_2021_2/widgets/input/image_selector.dart';
import 'package:pi_papers_2021_2/widgets/input/selector/selector.dart';
import 'package:pi_papers_2021_2/widgets/input/styled_slider.dart';
import 'package:pi_papers_2021_2/widgets/input/styled_radio.dart';
import 'package:pi_papers_2021_2/widgets/structure/footer.dart';
import 'package:pi_papers_2021_2/widgets/structure/header.dart';

import 'package:pi_papers_2021_2/algorithm/geometric_functions.dart';

class GeometricPage extends StatefulWidget {
  const GeometricPage({Key? key}) : super(key: key);

  @override
  State<GeometricPage> createState() => _GeometricPageState();
}

class _GeometricPageState extends State<GeometricPage> {
  Uint8List? imageA;
  Uint8List? imageB;
  GeometricFunction? operation;
  Map<String, int>? parameters;

  var selectedRadio = 'Horizontal';
  var selectedSlider = 0.0;
  var selectedSlider2 = 0.0;
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Transformações Geométricas',
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (operation != null)
                        Column(
                          children: [
                            operationControllers(),
                            FinishButton(
                              text: 'Transformar',
                              onPressed: () async {
                                setState(() => isLoading = true);

                                await Future.delayed(
                                  const Duration(seconds: 2),
                                );

                                setState(() {
                                  imageB = operate(
                                    image: imageA,
                                    inputs: {
                                      'moveX': selectedSlider.toInt(),
                                      'moveY': selectedSlider2.toInt(),
                                      'reflectionType': {
                                            'Horizontal': 1,
                                            'Vertical': 2
                                          }[selectedRadio] ??
                                          0,
                                      'rotation': selectedSlider.toInt(),
                                      'scale': (selectedSlider * 10).toInt(),
                                    },
                                    operation: operation,
                                  );

                                  isLoading = false;

                                  operation = null;
                                });
                              },
                            ),
                          ],
                        ),
                      ImageSelector(
                        isResult: false,
                        image: imageA != null ? Image.memory(imageA!) : null,
                        onTap: () async {
                          final pickedFile = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (pickedFile == null) return;
                          final fileBytes = await pickedFile.readAsBytes();
                          setState(() {
                            imageA = fileBytes;
                          });
                        },
                      ),
                      ImageSelector(
                        isResult: true,
                        image: imageB != null && imageB!.isNotEmpty
                            ? Image.memory(imageB!)
                            : null,
                        message: imageB == null
                            ? 'SEM IMAGEM\nPARA MOSTRAR'
                            : imageB!.isEmpty
                                ? 'IMAGENS TÊM\nTAMANHOS\nDIFERENTES'
                                : null,
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
                          if (operation == translation) return;
                          setState(() {
                            selectedSlider = 0.0;
                            selectedSlider2 = 0.0;
                            operation = translation;
                          });
                        },
                      ),
                      OperationSelection(
                        value: 'Rotação',
                        icon: ImageIcon(
                          AssetImage(
                              path('images/prototype/icons/rotation.png')),
                        ),
                        onPressed: () {
                          if (operation == rotation) return;
                          setState(() => operation = rotation);
                        },
                      ),
                      OperationSelection(
                        value: 'Escala',
                        icon: ImageIcon(
                          AssetImage(path('images/prototype/icons/scale.png')),
                        ),
                        onPressed: () {
                          if (operation == scale) return;
                          setState(() {
                            selectedSlider = 1.0;
                            operation = scale;
                          });
                        },
                      ),
                      OperationSelection(
                        value: 'Reflexão',
                        icon: ImageIcon(
                          AssetImage(
                              path('images/prototype/icons/reflection.png')),
                        ),
                        onPressed: () {
                          if (operation == reflection) return;
                          setState(() => operation = reflection);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
      bottomNavigationBar: const Footer(),
    );
  }

  SizedBox operationControllers() {
    final reflectionValues = ['Horizontal', 'Vertical', 'Ambos'];
    final sliderMinValues = {scale: 0.5, rotation: -180.0, translation: -50.0};
    final sliderMaxValues = {scale: 2.0, rotation: 180.0, translation: 50.0};

    return SizedBox(
      width: 400,
      child: Column(
        children: [
          if (operation != reflection)
            Row(
              children: [
                if (operation == translation)
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
                    min: sliderMinValues[operation]!,
                    max: sliderMaxValues[operation]!,
                    value: selectedSlider,
                    isDecimal: operation == scale,
                    onChanged: (value) {
                      setState(() {
                        selectedSlider = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          if (operation == translation)
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
                    value: selectedSlider2,
                    onChanged: (value) {
                      setState(() {
                        selectedSlider2 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          if (operation == reflection)
            Row(
              children: reflectionValues
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: StyledRadio(
                        value: e,
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = value!;
                          });
                        },
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
