// ignore_for_file: avoid_print
// TODO: delete file after using all components

import 'package:flutter/material.dart';

import 'package:pi_papers_2021_2/models/operation_selection.dart';

import 'package:pi_papers_2021_2/widgets/input/big_button.dart';
import 'package:pi_papers_2021_2/widgets/input/finish_button.dart';
import 'package:pi_papers_2021_2/widgets/input/image_selector.dart';
import 'package:pi_papers_2021_2/widgets/input/selector/selector.dart';
import 'package:pi_papers_2021_2/widgets/input/styled_radio.dart';
import 'package:pi_papers_2021_2/widgets/input/styled_slider.dart';
import 'package:pi_papers_2021_2/widgets/structure/footer.dart';
import 'package:pi_papers_2021_2/widgets/structure/header.dart';
import 'package:pi_papers_2021_2/widgets/structure/logo.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Operações Aritméticas',
      ),
      body: Wrap(
        children: [
          Selector(
            options: [
              OperationSelection(
                value: 'Adição',
                icon: const ImageIcon(
                  AssetImage("images/prototype/icons/plus.png"),
                ),
                onPressed: () => print('clicou adição'),
              ),
              OperationSelection(
                value: 'Subtração',
                icon: const ImageIcon(
                  AssetImage("images/prototype/icons/minus.png"),
                ),
                onPressed: () => print('clicou subtração'),
              ),
            ],
          ),
          FinishButton(
            text: 'OOPerar',
            onPressed: () {},
          ),
          const Logo(
            title: 'Operações Aritméticas',
          ),
          BigButton(
            onPressed: () {},
            text: 'Big Button',
          ),
          const ImageSelector(
            isResult: true,
          ),
          SizedBox(
            width: 400,
            child: StyledSlider(
              min: -700,
              max: 700,
              value: 0,
              onChanged: (value) => print(value),
            ),
          ),
          StyledRadio(
            value: 'Horizontal',
            groupValue: 'Vertical',
            onChanged: (sel) => print(sel),
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
