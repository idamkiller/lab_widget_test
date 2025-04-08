import 'package:flutter/material.dart';

class ScrollPage extends StatelessWidget {
  const ScrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de elementos para el ListView
    final List<String> items = List.generate(
      50,
      (index) => 'Elemento ${index + 1}',
    );

    return Scaffold(
      appBar: AppBar(
        key: const Key('scrollTestAppBar'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Prueba de Scroll'),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        key: const Key('scrollTestListView'),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            key: Key('card_$index'),
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              key: Key('listTile_$index'),
              title: Text(
                items[index],
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                'Descripción del ${items[index]}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              leading: CircleAvatar(
                key: Key('avatar_$index'),
                child: Text('${index + 1}'),
              ),
            ),
          );
        },
      ),
    );
  }
}
