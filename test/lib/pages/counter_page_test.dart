import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_widget_test/pages/counter_page.dart';

void main() {
  group('CounterPage Widget Tests', () {
    testWidgets('Verifica el título en AppBar', (WidgetTester tester) async {
      // Construir el widget
      await tester.pumpWidget(
        const MaterialApp(home: CounterPage(title: 'Mi Aplicación')),
      );

      // Buscar por Key específico del AppBar
      final appBar = find.byKey(const Key('appBar'));
      expect(appBar, findsOneWidget);

      // Verificar el texto del título
      expect(find.text('Mi Aplicación'), findsOneWidget);
    });

    testWidgets('Verifica el estilo y contenido de los textos', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(
        const MaterialApp(home: CounterPage(title: 'Mi Aplicación')),
      );

      // Buscar por Key específico del texto de contenido
      final contentText = find.byKey(const Key('content'));
      expect(contentText, findsOneWidget);

      // Verificar el texto específico
      expect(
        find.text('Tu has presionado el botón tantas veces:'),
        findsOneWidget,
      );

      // Verificar el estilo del texto
      final contentTextWidget = tester.widget<Text>(contentText);
      expect(contentTextWidget.style, isA<TextStyle>());
      // Verificar la alineación del texto
      expect(contentTextWidget.textAlign, TextAlign.center);
      // Verificar que el estilo es de tipo headlineSmall
      expect(
        contentTextWidget.style?.fontSize,
        // Valor por default de fontSize para headlineSmall
        equals(24.0), // Cambia este valor según el tamaño de fontSize que uses
      );
    });

    testWidgets('Verifica el contador y su estilo', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: CounterPage(title: 'Mi Aplicación')),
      );

      // Buscar por Key específico del contador
      final counterText = find.byKey(const Key('counter'));
      expect(counterText, findsOneWidget);

      // Verificar el valor inicial del contador
      expect(find.text('0'), findsOneWidget);

      // Verificar el estilo del contador
      final counterTextWidget = tester.widget<Text>(counterText);
      expect(counterTextWidget.style, isA<TextStyle>());
      // Verificar que el estilo es de tipo headlineMedium
      expect(
        counterTextWidget.style?.fontSize,
        // Valor por default de fontSize para headlineMedium
        equals(28.0), // Cambia este valor según el tamaño de fontSize que uses
      );
      // Verificar que el estilo es diferente al del contenido
      final contentText = find.byKey(const Key('content'));
      final contentTextWidget = tester.widget<Text>(contentText);
      expect(counterTextWidget.style, isNot(equals(contentTextWidget.style)));
    });

    testWidgets('Verifica el padding y alineación del Column', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: CounterPage(title: 'Mi Aplicación')),
      );

      // Buscar el Column por su Key
      final column = find.byKey(const Key('column'));
      expect(column, findsOneWidget);

      // Verificar el valor del padding del widget Padding
      final padding = tester.widget<Padding>(find.byKey(const Key('padding')));
      expect(padding.padding, const EdgeInsets.symmetric(horizontal: 16.0));

      // Verificar la alineación del Column
      final columnWidget = tester.widget<Column>(column);
      expect(columnWidget.mainAxisAlignment, MainAxisAlignment.center);
    });

    testWidgets('Verifica el funcionamiento del botón flotante', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: CounterPage(title: 'Mi Aplicación')),
      );

      // Buscar el FloatingActionButton por tipo
      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);

      // Verificar que el contador inicia en 0
      expect(find.text('0'), findsOneWidget);

      // Presionar el botón
      await tester.tap(fab);
      // pump para reconstruir el widget
      await tester.pump();

      // Verificar que el contador aumentó a 1
      expect(find.text('1'), findsOneWidget);
    });
  });
}
