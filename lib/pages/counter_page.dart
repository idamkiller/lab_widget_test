import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.title});

  final String title;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('appBar'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          key: const Key('padding'),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            key: const Key('column'),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                key: const Key('content'),
                'Tu has presionado el botón tantas veces:',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              Text(
                key: const Key('counter'),
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
