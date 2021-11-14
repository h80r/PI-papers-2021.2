import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/pages/test_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dr. Image',
      initialRoute: '/test',
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
      ),
      routes: {
        '/': (ctx) => const MyStatelessWidget(),
        '/test': (ctx) => const TestPage(),
      },
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floating Action Button'),
      ),
      body: const Center(child: Text('Press the button below!')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );
  }
}
