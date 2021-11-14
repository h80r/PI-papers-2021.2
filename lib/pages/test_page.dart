import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/widgets/input/big_button.dart';
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
          const Logo(
            title: 'Operações Aritméticas',
          ),
          BigButton(
            onPressed: () {},
            text: 'Big Button',
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
