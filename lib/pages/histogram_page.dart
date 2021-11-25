import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/widgets/histogram_graph.dart';
import 'package:pi_papers_2021_2/widgets/input/styled_dropdown.dart';
import 'package:pi_papers_2021_2/widgets/structure/header.dart';

class HistogramPage extends StatefulWidget {
  const HistogramPage({Key? key}) : super(key: key);

  @override
  _HistogramPageState createState() => _HistogramPageState();
}

class _HistogramPageState extends State<HistogramPage> {
  final intensityFrequency = <int, num>{};

  final menu = <String>[
    'Histograma',
    'Histograma normalizado',
    'Equalização de histograma',
    'Efeitos de Contrast Streching',
  ];

  String? currentValue;

// TODO: remover. Estes valores são temporários
  final valores = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    9,
  ];

  @override
  void initState() {
    currentValue = menu.first;

    for (final v in valores) {
      intensityFrequency.update(v, (value) => value + 1, ifAbsent: () => 1);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Processamento de Histograma',
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyleDropdown(
              items: menu,
              value: currentValue,
              onChanged: (newValue) => setState(() => currentValue = newValue!),
            ),
            HistogramGraph(intensityFrequency: intensityFrequency),
          ],
        ),
      ),
    );
  }
}
