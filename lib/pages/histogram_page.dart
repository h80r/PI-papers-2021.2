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

class HistogramPage extends StatefulWidget {
  const HistogramPage({Key? key}) : super(key: key);

  @override
  State<HistogramPage> createState() => _HistogramPageState();
}

class _HistogramPageState extends State<HistogramPage> {
  Uint8List? inputImage;
  String? dropdownCurrentValue;
  HistogramFunction? operation;
  HistogramResult? histogramResult;

  final menu = {
    'Histograma': histogramGeneration,
    'Histograma normalizado': normalizedHistogram,
    'Equalização de histograma': histogramEqualization,
    'Efeitos de Contrast Streching': contrastStreching,
  };

  @override
  void initState() {
    dropdownCurrentValue = menu.keys.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final resultImage = histogramResult?.get<Uint8List?>();
    final histogramData = histogramResult?.get<HistogramData>();

    return Scaffold(
      appBar: const Header(
        title: 'Processar Histogramas',
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
              image: inputImage != null ? Image.memory(inputImage!) : null,
              onTap: () async {
                final pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile == null) return;
                final fileBytes = await pickedFile.readAsBytes();
                setState(() => inputImage = fileBytes);
              },
            ),
            const SizedBox(width: 10),
            if (resultImage != null)
              ImageSelector(
                isResult: true,
                image: Image.memory(resultImage),
              ),
            const SizedBox(width: 10),
            if (histogramData != null)
              HistogramGraph(
                intensityFrequency: histogramData,
              ),
            const SizedBox(width: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyleDropdown(
                    items: menu.keys.toList(),
                    value: dropdownCurrentValue,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownCurrentValue = newValue;
                        operation = menu[newValue];
                      });
                    },
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
                    operation = menu[dropdownCurrentValue];
                    histogramResult = operate(inputImage, operation);
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
