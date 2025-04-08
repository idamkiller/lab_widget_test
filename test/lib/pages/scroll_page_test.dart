import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_widget_test/pages/scroll_page.dart';

void main() {
  group('ScrollTestPage Widget Tests', () {
    testWidgets('Verifica la estructura inicial de la página', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(const MaterialApp(home: ScrollPage()));

      // Verificar que el AppBar está presente
      expect(find.byKey(const Key('scrollTestAppBar')), findsOneWidget);
      expect(find.text('Prueba de Scroll'), findsOneWidget);

      // Verificar que el ListView está presente
      expect(find.byKey(const Key('scrollTestListView')), findsOneWidget);

      // Verificar que los primeros elementos son visibles
      expect(find.text('Elemento 1'), findsOneWidget);
      expect(find.text('Elemento 2'), findsOneWidget);
      expect(find.text('Elemento 3'), findsOneWidget);
    });

    testWidgets('Verifica el scroll y la carga de elementos', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(const MaterialApp(home: ScrollPage()));

      // Verificar elementos iniciales
      expect(find.text('Elemento 1'), findsOneWidget);
      expect(find.text('Elemento 10'), findsNothing);

      // Encuentra el ListView por su key
      final scrollable = find.byKey(const Key('scrollTestListView'));
      expect(tester.widget(scrollable), isA<ListView>());

      // Realizar scroll hacia abajo
      await tester.fling(
        scrollable,
        // Hacer scroll hacia abajo
        const Offset(0, -500),
        10000,
      );
      await tester.pumpAndSettle();

      // Verificar que no están los elementos
      expect(find.text('Elemento 1'), findsNothing);
      expect(find.text('Elemento 10'), findsNothing);
    });

    testWidgets('Hacer scroll hasta encontrar un item', (
      WidgetTester tester,
    ) async {
      final textToFind = 'Elemento 20';
      bool elementFound = false;

      // Construir el widget
      await tester.pumpWidget(const MaterialApp(home: ScrollPage()));

      // Verificar que el elemento no está visible inicialmente
      expect(find.text(textToFind), findsNothing);

      // Encuentra el ListView por su key
      final scrollable = find.byKey(const Key('scrollTestListView'));

      // Scroll hasta encontrar el elemento o llegar al final
      while (!elementFound) {
        // Verificar si el elemento ya está visible
        if (find.text(textToFind).evaluate().isNotEmpty) {
          elementFound = true;
          break;
        }

        // Hacer scroll hacia abajo
        await tester.fling(scrollable, const Offset(0, -300), 300);
        await tester.pump(const Duration(milliseconds: 400));
      }

      // Esperar a que la animación termine
      await tester.pumpAndSettle();

      // Verificar que encontramos el elemento
      expect(find.text(textToFind), findsOneWidget);
      expect(elementFound, true);
    });

    testWidgets('Verifica la estructura de los elementos de la lista', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(const MaterialApp(home: ScrollPage()));

      // Verificar la estructura del primer elemento
      expect(find.byKey(const Key('card_0')), findsOneWidget);
      expect(find.byKey(const Key('listTile_0')), findsOneWidget);
      expect(find.byKey(const Key('avatar_0')), findsOneWidget);

      // Verificar el contenido del primer elemento
      final firstCard = tester.widget<Card>(find.byKey(const Key('card_0')));
      expect(
        firstCard.margin,
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      );
    });

    testWidgets('Verifica el scroll hasta el final de la lista', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(const MaterialApp(home: ScrollPage()));

      // Realizar scroll hasta el final
      await tester.fling(
        find.byKey(const Key('scrollTestListView')),
        const Offset(0, -3000),
        10000,
      );
      await tester.pumpAndSettle();

      // Verificar que los últimos elementos son visibles
      expect(find.text('Elemento 48'), findsOneWidget);
      expect(find.text('Elemento 49'), findsOneWidget);
      expect(find.text('Elemento 50'), findsOneWidget);
    });

    testWidgets('Verifica que el scroll es vertical', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(const MaterialApp(home: ScrollPage()));

      // Buscar el ListView por su Key
      final listView = find.byKey(const Key('scrollTestListView'));
      // Verificar que el listView es de tipo ListView
      final listViewWidget = tester.widget<ListView>(listView);
      // Verificar que la dirección de scroll es vertical
      expect(listViewWidget.scrollDirection, Axis.vertical);
    });
  });
}
