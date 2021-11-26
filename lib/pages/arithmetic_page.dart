import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pi_papers_2021_2/models/operation_selection.dart';

import 'package:pi_papers_2021_2/widgets/input/finish_button.dart';
import 'package:pi_papers_2021_2/widgets/input/image_selector.dart';
import 'package:pi_papers_2021_2/widgets/input/selector/selector.dart';
import 'package:pi_papers_2021_2/widgets/structure/footer.dart';
import 'package:pi_papers_2021_2/widgets/structure/header.dart';

import 'package:pi_papers_2021_2/algorithm/arithmetic_functions.dart';

class ArithmeticPage extends StatefulWidget {
  const ArithmeticPage({Key? key}) : super(key: key);

  @override
  State<ArithmeticPage> createState() => _ArithmeticPageState();
}

class _ArithmeticPageState extends State<ArithmeticPage> {
  Uint8List? imageA;
  Uint8List? imageB;
  Uint8List? imageC;
  Uint8List Function(Uint8List, Uint8List)? operation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Operações Aritméticas',
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
            ImageSelector(
              isResult: true,
              image: imageC != null && imageC!.isNotEmpty
                  ? Image.memory(imageC!)
                  : null,
              message: imageC == null
                  ? 'SEM IMAGEM\nPARA MOSTRAR'
                  : imageC!.isEmpty
                      ? 'IMAGENS TÊM\nTAMANHOS\nDIFERENTES'
                      : null,
            ),
            Selector(
              options: [
                OperationSelection(
                  value: 'Adição',
                  icon: const ImageIcon(
                    AssetImage("images/prototype/icons/plus.png"),
                  ),
                  onPressed: () {
                    setState(() {
                      operation = sum;
                    });
                  },
                ),
                OperationSelection(
                  value: 'Subtração',
                  icon: const ImageIcon(
                    AssetImage("images/prototype/icons/minus.png"),
                  ),
                  onPressed: () {
                    setState(() {
                      operation = subtraction;
                    });
                  },
                ),
                OperationSelection(
                  value: 'Multiplicação',
                  icon: const ImageIcon(
                    AssetImage("images/prototype/icons/times.png"),
                  ),
                  onPressed: () {
                    setState(() {
                      operation = multiplication;
                    });
                  },
                ),
                OperationSelection(
                  value: 'Divisão',
                  icon: const ImageIcon(
                    AssetImage("images/prototype/icons/slash.png"),
                  ),
                  onPressed: () {
                    setState(() {
                      operation = division;
                    });
                  },
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            Center(
              child: FinishButton(
                text: 'Operar',
                onPressed: () {
                  setState(() {
                    imageC = operate(imageA, imageB, operation);
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
