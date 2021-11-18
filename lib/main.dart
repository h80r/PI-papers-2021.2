import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/pages/home_page.dart';
import 'package:pi_papers_2021_2/pages/test_page.dart';
import 'package:pi_papers_2021_2/pages/arithmethics_page.dart';
import 'package:pi_papers_2021_2/style/color_palette.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dr. Image',
      initialRoute: '/',
      theme: ThemeData(
        scaffoldBackgroundColor: ColorPalette.background,
      ),
      routes: {
        '/': (ctx) => const HomePage(),
        '/test': (ctx) => const TestPage(),
        '/arithmetic_operation': (ctx) => const ArithmethicsPage(),
        '/geometric_transformation': (ctx) =>
            const TestPage(), // TODO: create page
      },
    );
  }
}
