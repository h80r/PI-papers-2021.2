// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pi_papers_2021_2/models/operation_selection.dart';
import 'package:pi_papers_2021_2/widgets/input/finish_button.dart';

import 'package:pi_papers_2021_2/widgets/input/image_selector.dart';
import 'package:pi_papers_2021_2/widgets/input/selector/selector.dart';

import 'package:pi_papers_2021_2/widgets/structure/footer.dart';
import 'package:pi_papers_2021_2/widgets/structure/header.dart';

class ArithmethicsPage extends StatefulWidget {
  const ArithmethicsPage({Key? key}) : super(key: key);

  @override
  State<ArithmethicsPage> createState() => _ArithmethicsPageState();
}

class _ArithmethicsPageState extends State<ArithmethicsPage> {
  Uint8List? imageA;
  Uint8List? imageB;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Operações Aritméticas',
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
            ImageSelector(
              isResult: false,
              image: imageB != null ? Image.memory(imageB!) : null,
              onTap: () async {
                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile == null) return;
                final fileBytes = await pickedFile.readAsBytes();
                setState(() {
                  imageB = fileBytes;
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
                  value: 'Adição',
                  icon: Icons.add,
                  // ignore: avoid_print
                  onPressed: () => print('clicou adição'),
                ),
                OperationSelection(
                  value: 'Subtração',
                  icon: Icons.remove,
                  // ignore: avoid_print
                  onPressed: () => print('clicou subtração'),
                ),
                OperationSelection(
                  value: 'Multiplicação',
                  icon: Icons.star,
                  // ignore: avoid_print
                  onPressed: () => print('clicou multiplicação'),
                ),
                OperationSelection(
                  value: 'Divisão',
                  icon: Icons.pause_sharp,
                  onPressed: () => print('clicou divisão'),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
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
