import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/widgets/big_button.dart';
import 'package:pi_papers_2021_2/widgets/logo.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test')),
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
    );
  }
}
