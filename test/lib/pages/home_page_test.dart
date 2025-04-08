import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_widget_test/pages/home_page.dart';
import 'package:lab_widget_test/routes.dart';

void main() {
  group('HomePage Widget Tests', () {
    final widgetTest = MaterialApp(
      home: const HomePage(),
      routes: {
        Routes.scroll: (context) => const Scaffold(body: Text('Scroll Test')),
        Routes.counter: (context) => const Scaffold(body: Text('Counter')),
        Routes.form: (context) => const Scaffold(body: Text('Form')),
        Routes.semantics: (context) => const Scaffold(body: Text('Semantics')),
        Routes.animated: (context) => const Scaffold(body: Text('Animated')),
      },
    );
    testWidgets('Verifica la estructura básica de HomePage', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(widgetTest);

      // Verificar que el AppBar está presente con el título correcto
      expect(find.byKey(const Key('appBar')), findsOneWidget);
      // Verificar que el título es DWidget Test
      expect(find.text('Widget Test'), findsOneWidget);
    });

    testWidgets('Verifica los botones y su disposición', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(widgetTest);

      // Verificar que los botones están presentes
      expect(find.byKey(const Key('button_scroll')), findsOneWidget);
      expect(find.byKey(const Key('button_counter')), findsOneWidget);
      expect(find.byKey(const Key('button_form')), findsOneWidget);
      expect(find.byKey(const Key('button_semantics')), findsOneWidget);
      expect(find.byKey(const Key('button_animated')), findsOneWidget);

      // Verificar los textos de los botones
      expect(find.text('Ir a la página de Scroll'), findsOneWidget);
      expect(find.text('Ir a la página de Counter'), findsOneWidget);
      expect(find.text('Ir a la página de Formulario'), findsOneWidget);
      expect(find.text('Ir a la página de Semantics'), findsOneWidget);
      expect(find.text('Ir a la página de Animaciones'), findsOneWidget);

      // Verificar que los botones están dentro de un Column centrado
      final column = tester.widget<Column>(find.byType(Column));
      expect(column.mainAxisAlignment, MainAxisAlignment.center);
      expect(column.crossAxisAlignment, CrossAxisAlignment.center);
    });

    testWidgets('Verifica la navegación al botón de Scroll', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(widgetTest);

      // Presionar el botón
      await tester.tap(find.byKey(const Key('button_scroll')));
      await tester.pumpAndSettle();

      // Verificar que se navegó a la página
      expect(find.text('Scroll Test'), findsOneWidget);
    });

    testWidgets('Verifica la navegación al botón de Counter', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(widgetTest);

      // Presionar el botón
      await tester.tap(find.byKey(const Key('button_counter')));
      await tester.pumpAndSettle();

      // Verificar que se navegó a la página
      expect(find.text('Counter'), findsOneWidget);
    });

    testWidgets('Verifica la navegación al botón de Formulario', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(widgetTest);

      // Presionar el botón
      await tester.tap(find.byKey(const Key('button_form')));
      await tester.pumpAndSettle();

      // Verificar que se navegó a la página
      expect(find.text('Form'), findsOneWidget);
    });

    testWidgets('Verifica la navegación al botón de Semantics', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(widgetTest);

      // Presionar el botón
      await tester.tap(find.byKey(const Key('button_semantics')));
      await tester.pumpAndSettle();

      // Verificar que se navegó a la página
      expect(find.text('Semantics'), findsOneWidget);
    });

    testWidgets('Verifica la navegación al botón de Animaciones', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(widgetTest);

      // Presionar el botón
      await tester.tap(find.byKey(const Key('button_animated')));
      await tester.pumpAndSettle();

      // Verificar que se navegó a la página
      expect(find.text('Animated'), findsOneWidget);
    });

    testWidgets('Verifica el estilo de los botones', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(widgetTest);

      // Verificar que los botones son ElevatedButton
      final scrollButton = tester.widget<ElevatedButton>(
        find.byKey(const Key('button_scroll')),
      );
      final counterButton = tester.widget<ElevatedButton>(
        find.byKey(const Key('button_counter')),
      );
      final formButton = tester.widget<ElevatedButton>(
        find.byKey(const Key('button_form')),
      );
      final semanticsButton = tester.widget<ElevatedButton>(
        find.byKey(const Key('button_semantics')),
      );
      final animatedButton = tester.widget<ElevatedButton>(
        find.byKey(const Key('button_animated')),
      );

      expect(scrollButton, isA<ElevatedButton>());
      expect(counterButton, isA<ElevatedButton>());
      expect(formButton, isA<ElevatedButton>());
      expect(semanticsButton, isA<ElevatedButton>());
      expect(animatedButton, isA<ElevatedButton>());
    });

    testWidgets('Verifica el icono de Flutter', (WidgetTester tester) async {
      // Construir el widget
      await tester.pumpWidget(widgetTest);

      // Verificar que el icono está presente
      expect(find.byKey(const Key('icon')), findsOneWidget);
      expect(find.byIcon(Icons.flutter_dash), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('Buscar por texto parcial', (WidgetTester tester) async {
      // Construir el widget
      await tester.pumpWidget(widgetTest);

      // Verificar que el texto "Ir a la página de" está presente
      expect(find.textContaining('Ir a la página de'), findsNWidgets(5));
    });

    testWidgets('Buscar por texto específico con byWidgetPredicate', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(widgetTest);

      // Presionar el botón
      await tester.tap(
        find.byWidgetPredicate(
          (widget) => widget is Text && widget.data!.contains('Animaciones'),
        ),
      );
      await tester.pumpAndSettle();

      // Verificar que se navegó a la página de Animaciones
      expect(find.text('Animated'), findsOneWidget);
    });
  });
}
