import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/style/color_palette.dart';

class HistogramGraph extends StatelessWidget {
  const HistogramGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 500,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: ColorPalette.primary,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BarChart(data),
        ),
      ),
    );
  }

  BarChartData get data => BarChartData(
        borderData: FlBorderData(show: false),
        titlesData: titlesData,
        barGroups: barGroups,
      );

  FlTitlesData get titlesData => FlTitlesData(
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => titleStyle,
        ),
        leftTitles: SideTitles(
          reservedSize: 30,
          showTitles: true,
          getTextStyles: (context, value) => titleStyle,
        ),
      );

  TextStyle get titleStyle => const TextStyle(
        color: ColorPalette.secondary,
        fontWeight: FontWeight.bold,
        fontFamily: 'SF Pro Display',
        fontSize: 14,
      );

  List<BarChartGroupData> get barGroups => [0, 1, 2, 3, 4, 5, 6, 7]
      .map((e) => BarChartGroupData(
            x: e,
            barRods: [
              BarChartRodData(
                y: 7, // TODO: y = receber o valor de vezes que a cor se repete
                colors: [
                  ColorPalette.background
                ], // TODO: receber o valor da cor x
                borderRadius: BorderRadius.circular(20.0),
              ),
            ],
          ))
      .toList();
}
