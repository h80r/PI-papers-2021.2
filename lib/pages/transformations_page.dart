// ignore_for_file: avoid_print, duplicate_ignore

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

import 'package:pi_papers_2021_2/algorithm/geometric_trans.dart';

class TransformationsPage extends StatefulWidget {
  const TransformationsPage({Key? key}) : super(key: key);

  @override
  State<TransformationsPage> createState() => _TransformationsPageState();
}

class _TransformationsPageState extends State<TransformationsPage> {
  Uint8List? imageA;
  Uint8List? imageB;
  String selectedRadio = 'Horizontal';
  double selectedSlider = 1;
  double selectedSlider2 = 1;
  Function()? transformation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Transformações Geométricas',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 5.0,
          runSpacing: 16.0,
          alignment: WrapAlignment.center,
          children: [
            ImageSelector(
              isResult: false,
              image: imageA != null ? Image.memory(imageA!) : null,
              onTap: () async {
                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
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
            Selector(
              options: [
                OperationSelection(
                  value: 'Translação',
                  icon: Icons.settings_overscan,
                  // ignore: avoid_print
                  onPressed: () {
                    if (transformation != translation) {
                      setState(() {
                        selectedSlider = 1;
                        transformation = translation;
                      });
                    }
                  },
                ),
                OperationSelection(
                  value: 'Rotação',
                  icon: Icons.rotate_right,
                  // ignore: avoid_print
                  onPressed: () {
                    if (transformation != rotation) {
                      setState(() {
                        selectedSlider = 1;
                        transformation = rotation;
                      });
                    }
                  },
                ),
                OperationSelection(
                  value: 'Escala',
                  icon: Icons.photo_size_select_large,
                  // ignore: avoid_print
                  onPressed: () {
                    if (transformation != scale) {
                      setState(() {
                        selectedSlider = 1;
                        transformation = scale;
                      });
                    }
                  },
                ),
                OperationSelection(
                  value: 'Reflexão',
                  // Talvez usar Icons.flip
                  icon: Icons.compare,
                  onPressed: () {
                    setState(() {
                      transformation = reflection;
                    });
                  },
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            SizedBox(
              width: 400,
              child: transformation == translation
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                    print(selectedSlider);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
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
                      ],
                    )
                  : transformation == rotation
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
                      : transformation == scale
                          ? StyledSlider(
                              min: 0.5,
                              max: 2,
                              value: selectedSlider,
                              onChanged: (value) {
                                setState(() {
                                  selectedSlider = value;
                                  print(selectedSlider);
                                });
                              },
                            )
                          : transformation == reflection
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      StyledRadio(
                                        value: 'Horizontal',
                                        groupValue: selectedRadio,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedRadio = value!;
                                            print(selectedRadio);
                                          });
                                        },
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.all(10.0)),
                                      StyledRadio(
                                        value: 'Vertical',
                                        groupValue: selectedRadio,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedRadio = value!;
                                            print(selectedRadio);
                                          });
                                        },
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.all(10.0)),
                                      StyledRadio(
                                        value: 'Ambos',
                                        groupValue: selectedRadio,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedRadio = value!;
                                            print(selectedRadio);
                                          });
                                        },
                                      )
                                    ])
                              : null,
            ),
            Center(
              child: FinishButton(
                text: 'Transformar',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
