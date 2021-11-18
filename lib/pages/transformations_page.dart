// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pi_papers_2021_2/models/operation_selection.dart';
import 'package:pi_papers_2021_2/widgets/input/finish_button.dart';

import 'package:pi_papers_2021_2/widgets/input/image_selector.dart';
import 'package:pi_papers_2021_2/widgets/input/selector/selector.dart';
import 'package:pi_papers_2021_2/widgets/input/styled_slider.dart';

import 'package:pi_papers_2021_2/widgets/structure/footer.dart';
import 'package:pi_papers_2021_2/widgets/structure/header.dart';

class TransformationsPage extends StatefulWidget {
  const TransformationsPage({Key? key}) : super(key: key);

  @override
  State<TransformationsPage> createState() => _TransformationsPageState();
}

class _TransformationsPageState extends State<TransformationsPage> {
  Uint8List? imageA;
  Uint8List? imageB;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Transformações Geométricas',
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
            const ImageSelector(
              isResult: true,
            ),
            Selector(
              options: [
                OperationSelection(
                  value: 'Translação',
                  icon: Icons.settings_overscan,
                  // ignore: avoid_print
                  onPressed: () => print('clicou translação'),
                ),
                OperationSelection(
                  value: 'Rotação',
                  icon: Icons.rotate_right,
                  // ignore: avoid_print
                  onPressed: () => print('clicou rotação'),
                ),
                OperationSelection(
                  value: 'Escala',
                  icon: Icons.photo_size_select_large,
                  // ignore: avoid_print
                  onPressed: () => print('clicou escala'),
                ),
                OperationSelection(
                  value: 'Reflexão',
                  // Talvez usar Icons.flip
                  icon: Icons.compare,
                  onPressed: () => print('clicou reflexão'),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            SizedBox(
              width: 400,
              child: StyledSlider(
                min: -180,
                max: 180,
                value: 0,
                onChanged: (value) => print(value),
              ),
            ),
            Center(
              child: FinishButton(
                text: 'Operar',
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
