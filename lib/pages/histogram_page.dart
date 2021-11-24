import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/widgets/input/styled_dropdown.dart';
import 'package:pi_papers_2021_2/widgets/structure/header.dart';

class HistogramPage extends StatefulWidget {
  const HistogramPage({Key? key}) : super(key: key);

  @override
  _HistogramPageState createState() => _HistogramPageState();
}

final menu = <String>[
  'Histograma',
  'Histograma normalizado',
  'Enhancement',
  'Equalização de histograma',
  'Efeitos de Contrast Streching',
];

class _HistogramPageState extends State<HistogramPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Processamento de Histograma',
      ),
      body: StyleDropdown(items: menu),
    );
  }
}
