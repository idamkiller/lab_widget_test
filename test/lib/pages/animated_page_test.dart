import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_widget_test/pages/animated_page.dart';

void main() {
  group('AnimatedPage Widget Tests', () {
    testWidgets('Verifica el estado inicial de la animación', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(const MaterialApp(home: AnimatedPage()));

      // Verificar que el AppBar existe con el título correcto
      expect(find.byKey(const Key('animatedAppBar')), findsOneWidget);
      expect(find.text('Prueba de Animaciones'), findsOneWidget);

      // Verificar que el contenedor animado existe en su estado inicial
      final container = find.byKey(const Key('animatedContainer'));
      expect(container, findsOneWidget);

      // Obtener las propiedades iniciales del contenedor
      final containerWidget = tester.widget<AnimatedContainer>(container);
      final RenderBox renderBox = tester.renderObject<RenderBox>(container);
      expect(renderBox.size.width, 100.0);
      expect(renderBox.size.height, 100.0);
      expect(containerWidget.decoration, isA<BoxDecoration>());
      final decoration = containerWidget.decoration as BoxDecoration;
      expect(decoration.color, Colors.blue);
      expect(decoration.borderRadius, BorderRadius.circular(0));
    });

    testWidgets('Verifica la transición de la animación', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(const MaterialApp(home: AnimatedPage()));

      // Verificar estado inicial
      final animatedContainer = find.byKey(const Key('animatedContainer'));
      var renderBox = tester.renderObject<RenderBox>(animatedContainer);
      expect(renderBox.size.width, 100.0);

      // Presionar el botón para activar la animación
      await tester.tap(find.byKey(const Key('animateButton')));

      // Verificar que la animación se inicia
      await tester.pumpAndSettle();
      renderBox = tester.renderObject<RenderBox>(animatedContainer);
      expect(renderBox.size.width, 200.0); // El valor final esperado

      await tester.pumpAndSettle();

      // Verificar estado final
      renderBox = tester.renderObject<RenderBox>(animatedContainer);
      expect(renderBox.size.width, 200.0);
      expect(renderBox.size.height, 200.0);
      final containerWidget = tester.widget<AnimatedContainer>(
        animatedContainer,
      );
      final decoration = containerWidget.decoration as BoxDecoration;
      expect(decoration.color, Colors.red);
      expect(decoration.borderRadius, BorderRadius.circular(50));
    });

    testWidgets('Verifica ciclo completo de la animación', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(const MaterialApp(home: AnimatedPage()));

      // Estado inicial -> expandido -> estado inicial
      for (int i = 0; i < 2; i++) {
        // Obtener el estado actual
        final container = find.byKey(const Key('animatedContainer'));
        var renderBox = tester.renderObject<RenderBox>(container);
        final initialWidth = renderBox.size.width;

        // Presionar para cambiar estado
        await tester.tap(find.byKey(const Key('animateButton')));
        await tester.pumpAndSettle(); // Esperar a que termine la animación

        // Verificar que el estado ha cambiado
        renderBox = tester.renderObject<RenderBox>(container);
        expect(renderBox.size.width, isNot(initialWidth));
      }

      // Al final debería estar en estado inicial de nuevo
      final container = find.byKey(const Key('animatedContainer'));
      final renderBox = tester.renderObject<RenderBox>(container);
      expect(renderBox.size.width, 100.0);
      expect(renderBox.size.height, 100.0);
    });

    testWidgets('Verifica la duración de la animación', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(const MaterialApp(home: AnimatedPage()));

      // Verificar que la duración de la animación es correcta
      final container = find.byKey(const Key('animatedContainer'));
      final containerWidget = tester.widget<AnimatedContainer>(container);
      expect(containerWidget.duration, const Duration(milliseconds: 300));

      // Verificar que la curva de la animación es correcta
      expect(containerWidget.curve, Curves.fastOutSlowIn);
    });
  });
}
