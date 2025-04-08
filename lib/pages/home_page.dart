import 'package:flutter/material.dart';
import 'package:lab_widget_test/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('appBar'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Widget Test'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            Icon(
              Icons.flutter_dash,
              key: const Key('icon'),
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            ElevatedButton(
              key: const Key('button_scroll'),
              onPressed: () {
                Navigator.pushNamed(context, Routes.scroll);
              },
              child: const Text('Ir a la página de Scroll'),
            ),
            ElevatedButton(
              key: const Key('button_counter'),
              onPressed: () {
                Navigator.pushNamed(context, Routes.counter);
              },
              child: const Text('Ir a la página de Counter'),
            ),
            ElevatedButton(
              key: const Key('button_form'),
              onPressed: () {
                Navigator.pushNamed(context, Routes.form);
              },
              child: const Text('Ir a la página de Formulario'),
            ),
            ElevatedButton(
              key: const Key('button_semantics'),
              onPressed: () {
                Navigator.pushNamed(context, Routes.semantics);
              },
              child: const Text('Ir a la página de Semantics'),
            ),
            ElevatedButton(
              key: const Key('button_animated'),
              onPressed: () {
                Navigator.pushNamed(context, Routes.animated);
              },
              child: const Text('Ir a la página de Animaciones'),
            ),
          ],
        ),
      ),
    );
  }
}
