import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pi_papers_2021_2/widgets/input/finish_button.dart';
import 'package:pi_papers_2021_2/widgets/input/image_selector.dart';
import 'package:pi_papers_2021_2/widgets/structure/footer.dart';
import 'package:pi_papers_2021_2/widgets/structure/header.dart';
import 'package:pi_papers_2021_2/widgets/histogram_graph.dart';
import 'package:pi_papers_2021_2/widgets/input/styled_dropdown.dart';

import 'package:pi_papers_2021_2/algorithm/histogram_functions.dart';
import 'package:pi_papers_2021_2/algorithm/arithmetic_functions.dart';

class HistogramPage extends StatefulWidget {
  const HistogramPage({Key? key}) : super(key: key);

  @override
  State<HistogramPage> createState() => _HistogramPageState();
}

class _HistogramPageState extends State<HistogramPage> {
  Uint8List? imageA;
  Uint8List? imageB;
  dynamic operation;
  String? dropdownCurrentValue;
  List? pixelsLuminanceValues;

  final menu = <String>[
    'Histograma',
    'Histograma normalizado',
    'Equalização de histograma',
    'Efeitos de Contrast Streching',
  ];

  @override
  void initState() {
    dropdownCurrentValue = menu.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Processamento de Histogramas',
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
            if (imageB != null)
              ImageSelector(
                isResult: true,
                image: Image.memory(imageB!),
              ),
            const SizedBox(width: 10),
            if (pixelsLuminanceValues != null)
              HistogramGraph(
                  intensityFrequency:
                      getIntensityFrequency(pixelsLuminanceValues)),
            const SizedBox(width: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyleDropdown(
                    items: menu,
                    value: dropdownCurrentValue,
                    onChanged: (newValue) =>
                        setState(() => dropdownCurrentValue = newValue!),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            Center(
              child: FinishButton(
                text: 'Processar',
                onPressed: () {
                  setState(() {
                    operation = getOperation(dropdownCurrentValue);

                    if (operation != getHistogram &&
                        operation != getNormalizedHistogram) {
                      imageB = operate(imageA, imageA, sum);
                    } else {
                      imageB = null;
                    }
                    pixelsLuminanceValues = [
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      1,
                      1,
                      1,
                      1,
                      1,
                      1,
                      1,
                      2,
                      2,
                      2,
                      2,
                      2,
                      2,
                      2,
                      3,
                      3,
                      3,
                      3,
                      3,
                      3,
                      3,
                      4,
                      4,
                      4,
                      4,
                      4,
                      4,
                      4,
                      5,
                      5,
                      5,
                      5,
                      5,
                      5,
                      5,
                      6,
                      6,
                      6,
                      6,
                      6,
                      6,
                      6,
                      9
                    ];
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
