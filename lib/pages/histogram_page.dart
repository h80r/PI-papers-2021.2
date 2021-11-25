import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/widgets/histogram_graph.dart';
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
  'Equalização de histograma',
  'Efeitos de Contrast Streching',
];

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

class _HistogramPageState extends State<HistogramPage> {
  @override
  Widget build(BuildContext context) {
    final intensityFrequency = <int, num>{};

    for (final v in valores) {
      intensityFrequency.update(v, (value) => value + 1, ifAbsent: () => 1);
    }

    return Scaffold(
      appBar: const Header(
        title: 'Processamento de Histograma',
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyleDropdown(items: menu),
            HistogramGraph(intensityFrequency: intensityFrequency),
          ],
        ),
      ),
    );
  }
}
