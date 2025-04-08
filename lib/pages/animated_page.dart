import 'package:flutter/material.dart';

class AnimatedPage extends StatefulWidget {
  const AnimatedPage({super.key});

  @override
  State<AnimatedPage> createState() => _AnimatedPageState();
}

class _AnimatedPageState extends State<AnimatedPage> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('animatedAppBar'),
        title: const Text('Prueba de Animaciones'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              key: const Key('animatedContainer'),
              width: _expanded ? 200.0 : 100.0,
              height: _expanded ? 200.0 : 100.0,
              decoration: BoxDecoration(
                color: _expanded ? Colors.red : Colors.blue,
                borderRadius: BorderRadius.circular(_expanded ? 50.0 : 0.0),
              ),
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              key: const Key('animateButton'),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              child: Text(_expanded ? 'Contraer' : 'Expandir'),
            ),
          ],
        ),
      ),
    );
  }
}
