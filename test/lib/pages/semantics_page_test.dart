import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_widget_test/pages/semantics_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SemanticsPage Tests', () {
    const widetTest = MaterialApp(home: SemanticsPage());
    testWidgets('Verifica la estructura básica de la página', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(widetTest);

      // Verificar que el AppBar está presente con el título correcto
      expect(find.byKey(const Key('appBar')), findsOneWidget);
      expect(find.text('Semantics'), findsOneWidget);

      // Verificar que los elementos principales están presentes
      expect(find.byKey(const Key('semantics_button')), findsOneWidget);
      expect(find.byKey(const Key('semantics_text')), findsOneWidget);
      expect(find.byKey(const Key('semantics_image')), findsOneWidget);

      // Verificar que los elementos hijos están presentes
      expect(find.byKey(const Key('button')), findsOneWidget);
      expect(find.byKey(const Key('text')), findsOneWidget);
      expect(find.byKey(const Key('image')), findsOneWidget);

      // Verificar el texto visible
      expect(find.text('Enviar'), findsOneWidget);
      expect(find.text('Texto de prueba'), findsOneWidget);
    });

    testWidgets('Verifica las propiedades semánticas del botón', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(widetTest);

      // Obtener el nodo semántico del botón
      final SemanticsNode buttonNode = tester.getSemantics(
        find.byKey(const Key('semantics_button')),
      );

      // Verificar las propiedades semánticas correctas
      expect(buttonNode.label, 'Enviar formulario');
      expect(buttonNode.hint, 'Presiona para enviar el formulario');
      expect(buttonNode.hasFlag(SemanticsFlag.isButton), isTrue);
    });

    testWidgets('Verifica las propiedades semánticas del texto', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(widetTest);

      // Obtener el nodo semántico del texto
      final SemanticsNode textNode = tester.getSemantics(
        find.byKey(const Key('semantics_text')),
      );

      // Verificar las propiedades semánticas correctas
      expect(textNode.label, 'Mensaje informativo');
      expect(textNode.hasFlag(SemanticsFlag.isReadOnly), isTrue);
    });

    testWidgets('Verifica las propiedades semánticas de la imagen', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(widetTest);

      // Obtener el nodo semántico de la imagen
      final SemanticsNode imageNode = tester.getSemantics(
        find.byKey(const Key('semantics_image')),
      );

      // Verificar las propiedades semánticas correctas
      expect(imageNode.label, 'Imagen decorativa de prueba');
      expect(imageNode.hasFlag(SemanticsFlag.isImage), isTrue);
    });

    testWidgets('Verifica que las etiquetas semánticas excluyen a los hijos', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(widetTest);

      // Obtener todos los nodos semánticos
      final SemanticsHandle handle = tester.ensureSemantics();

      // Verificar que no existe un nodo semántico directo para el texto excluido
      expect(
        tester.getSemantics(find.byKey(const Key('text'))).label,
        isNot(equals('Texto de prueba')),
      );

      // Limpiar recursos
      handle.dispose();
    });

    testWidgets('Verifica la carga de la imagen asset', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(widetTest);

      // Verificar que el widget Image está presente
      expect(find.byType(Image), findsOneWidget);

      // Verificar que la imagen se carga correctamente
      final Image image = tester.widget(find.byType(Image));
      expect(image.image, isA<AssetImage>());
      expect(
        (image.image as AssetImage).assetName,
        'assets/images/150x150.png',
      );
    });

    testWidgets('Verifica click en el botón y muestra el SnackBar', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(widetTest);

      // Verificar que el SnackBar no está presente al inicio
      expect(find.byKey(const Key('success_snackbar')), findsNothing);
      expect(find.text('Formulario enviado'), findsNothing);

      // Hacer clic en el botón
      await tester.tap(find.byKey(const Key('button')));
      await tester.pumpAndSettle();
      // Verificar que el SnackBar se muestra
      expect(find.byKey(const Key('success_snackbar')), findsOneWidget);
      expect(find.text('Formulario enviado'), findsOneWidget);
    });
  });
}
