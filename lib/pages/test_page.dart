import 'package:flutter/material.dart';

import 'package:pi_papers_2021_2/models/operation_selection.dart';

import 'package:pi_papers_2021_2/widgets/input/big_button.dart';
import 'package:pi_papers_2021_2/widgets/input/finish_button.dart';
import 'package:pi_papers_2021_2/widgets/input/image_selector.dart';
import 'package:pi_papers_2021_2/widgets/input/selector/selector.dart';
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
                icon: Icons.add,
                onPressed: () => print('clicou adição'),
              ),
              OperationSelection(
                value: 'Subtração',
                icon: Icons.remove,
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
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
