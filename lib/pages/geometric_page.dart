import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pi_papers_2021_2/models/operation_selection.dart';

import 'package:pi_papers_2021_2/style/color_palette.dart';

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
                      Column(
                        children: [
                          SizedBox(
                            width: 400,
                            child: operation == translation
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
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
                                              min: -50,
                                              max: 50,
                                              value: selectedSlider,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedSlider = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                    ],
                                  )
                                : operation == rotation
                                    ? StyledSlider(
                                        min: -180,
                                        max: 180,
                                        value: selectedSlider,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedSlider = value;
                                          });
                                        },
                                      )
                                    : operation == scale
                                        ? StyledSlider(
                                            min: 0.5,
                                            max: 2,
                                            value: selectedSlider,
                                            isDecimal: true,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedSlider = value;
                                              });
                                            },
                                          )
                                        : operation == reflection
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  StyledRadio(
                                                    value: 'Horizontal',
                                                    groupValue: selectedRadio,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedRadio = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0)),
                                                  StyledRadio(
                                                    value: 'Vertical',
                                                    groupValue: selectedRadio,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedRadio = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0)),
                                                  StyledRadio(
                                                    value: 'Ambos',
                                                    groupValue: selectedRadio,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedRadio = value!;
                                                      });
                                                    },
                                                  )
                                                ],
                                              )
                                            : null,
                          ),
                          FinishButton(
                            text: 'Transformar',
                            onPressed: () async {
                              setState(() => isLoading = true);

                              await Future.delayed(const Duration(seconds: 2));

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
                              });
                            },
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 5.0,
                        runSpacing: 16.0,
                        alignment: WrapAlignment.center,
                        children: [
                          ImageSelector(
                            isResult: false,
                            image:
                                imageA != null ? Image.memory(imageA!) : null,
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
                          const SizedBox(width: 10),
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
                          const Padding(padding: EdgeInsets.all(16.0)),
                        ],
                      ),
                    ],
                  ),
                  Selector(
                    options: [
                      OperationSelection(
                        value: 'Translação',
                        icon: const ImageIcon(
                          AssetImage("images/prototype/icons/translation.png"),
                        ),
                        onPressed: () {
                          if (operation == translation) return;
                          setState(() => operation = translation);
                        },
                      ),
                      OperationSelection(
                        value: 'Rotação',
                        icon: const ImageIcon(
                          AssetImage("images/prototype/icons/rotation.png"),
                        ),
                        onPressed: () {
                          if (operation == rotation) return;
                          setState(() => operation = rotation);
                        },
                      ),
                      OperationSelection(
                        value: 'Escala',
                        icon: const ImageIcon(
                          AssetImage("images/prototype/icons/scale.png"),
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
                        icon: const ImageIcon(
                          AssetImage("images/prototype/icons/reflection.png"),
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
}
