import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pi_papers_2021_2/widgets/input/finish_button.dart';
import 'package:pi_papers_2021_2/widgets/input/image_selector.dart';
import 'package:pi_papers_2021_2/widgets/structure/footer.dart';
import 'package:pi_papers_2021_2/widgets/structure/header.dart';

import 'package:pi_papers_2021_2/algorithm/histogram_functions.dart';

class HistogramPage extends StatefulWidget {
  const HistogramPage({Key? key}) : super(key: key);

  @override
  State<HistogramPage> createState() => _HistogramPageState();
}

class _HistogramPageState extends State<HistogramPage> {
  Uint8List? imageA;
  Uint8List? imageB;
  Uint8List? chart;
  dynamic operation;

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
            Center(
              child: ImageSelector(
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
            ),
            const SizedBox(width: 10),
            if (imageB != null)
              ImageSelector(
                isResult: true,
                image: Image.memory(imageB!),
              ),
            const SizedBox(width: 10),
            // TODO: Add chart component here
            // const SizedBox(width: 10),
            // TODO: Add dropdown here
            const Padding(padding: EdgeInsets.all(16.0)),
            Center(
              child: FinishButton(
                text: 'Processar',
                onPressed: () {
                  setState(() {
                    if (operation != getHistogram &&
                        operation != getNormalizedHistogram) {
                      imageB = operation(imageA);
                    }
                    chart = operation(imageA);
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
