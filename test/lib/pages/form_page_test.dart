import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_widget_test/pages/form_page.dart';

void main() {
  group('FormPage Widget Tests', () {
    testWidgets('Verifica la estructura básica del formulario', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(const MaterialApp(home: FormPage()));

      // Verificar que el AppBar está presente con el título correcto
      expect(find.byKey(const Key('appBar')), findsOneWidget);
      expect(find.text('Formulario'), findsOneWidget);

      // Verificar que los campos del formulario están presentes
      expect(find.byKey(const Key('nameField')), findsOneWidget);
      expect(find.byKey(const Key('emailField')), findsOneWidget);
      expect(find.byKey(const Key('submitButton')), findsOneWidget);

      // Verificar las etiquetas de los campos
      expect(find.text('Nombre'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Enviar'), findsOneWidget);
    });

    testWidgets('Verifica el valor inicial del campo nombre', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(const MaterialApp(home: FormPage()));

      // Encontrar el TextFormField por su key
      final nameField = find.byKey(const Key('nameField'));

      // Verificar que el campo tiene el valor inicial correcto
      expect(
        (tester.widget(nameField) as TextFormField).initialValue,
        'Nombre de prueba',
      );
    });

    testWidgets('Verifica la validación de campos vacíos', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(const MaterialApp(home: FormPage()));

      // Borrar el campo de nombre que tiene valor inicial
      await tester.enterText(find.byKey(const Key('nameField')), '');

      // Presionar el botón de enviar
      await tester.tap(find.byKey(const Key('submitButton')));
      await tester.pumpAndSettle();

      // Verificar que se muestra el mensaje de error para campos vacíos
      expect(find.text('Por favor ingrese su nombre'), findsOneWidget);
      expect(find.text('Por favor ingrese su email'), findsOneWidget);

      // Verificar que se mostró el SnackBar con el mensaje de error
      expect(find.text('Error al enviar el formulario'), findsOneWidget);
    });

    testWidgets('Verifica el envío exitoso del formulario', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(const MaterialApp(home: FormPage()));

      // Ingresar datos válidos en los campos
      // El campo nombre ya tiene un valor inicial
      await tester.enterText(
        find.byKey(const Key('emailField')),
        'test@example.com',
      );

      // Presionar el botón de enviar
      await tester.tap(find.byKey(const Key('submitButton')));
      await tester.pumpAndSettle();

      // Verificar que se mostró el SnackBar con el mensaje de éxito
      expect(find.text('Formulario enviado'), findsOneWidget);
    });

    testWidgets('Verifica la interacción con los campos del formulario', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(const MaterialApp(home: FormPage()));

      // Modificar el valor del campo nombre
      await tester.enterText(
        find.byKey(const Key('nameField')),
        'Nuevo Nombre',
      );

      // Verificar que el texto se actualizó correctamente
      expect(find.text('Nuevo Nombre'), findsOneWidget);

      // Enfocar el campo de email
      await tester.tap(find.byKey(const Key('emailField')));
      await tester.pumpAndSettle();

      // Ingresar texto en el campo de email
      await tester.enterText(
        find.byKey(const Key('emailField')),
        'correo@test.com',
      );

      // Verificar que el texto se actualizó correctamente
      expect(find.text('correo@test.com'), findsOneWidget);
    });

    testWidgets('Verifica el comportamiento del Form', (
      WidgetTester tester,
    ) async {
      // Construir el widget
      await tester.pumpWidget(const MaterialApp(home: FormPage()));

      // Verificar que hay un widget Form
      expect(find.byType(Form), findsOneWidget);

      // Verificar que el Form tiene la key correcta
      final form = tester.widget<Form>(find.byType(Form));
      expect(form.key, equals(formKey));
    });

    testWidgets(
      'Verifica que el ScaffoldMessenger muestre el SnackBar de éxito',
      (WidgetTester tester) async {
        // Construir el widget
        await tester.pumpWidget(const MaterialApp(home: FormPage()));

        // El campo nombre ya tiene valor inicial
        // Ingresar valor en el campo email
        await tester.enterText(
          find.byKey(const Key('emailField')),
          'test@example.com',
        );

        // Presionar el botón de enviar
        await tester.tap(find.byKey(const Key('submitButton')));

        // Esperar a que aparezca el SnackBar
        await tester.pumpAndSettle();

        // Verificar que el ScaffoldMessenger muestra el SnackBar
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Formulario enviado'), findsOneWidget);

        // Verificar propiedades específicas del SnackBar
        final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
        expect(snackBar.content, isA<Text>());
      },
    );

    testWidgets(
      'Verifica que el ScaffoldMessenger muestre el SnackBar de error',
      (WidgetTester tester) async {
        // Construir el widget
        await tester.pumpWidget(const MaterialApp(home: FormPage()));

        // Borrar el campo nombre (que tiene valor inicial)
        await tester.enterText(find.byKey(const Key('nameField')), '');

        // Presionar el botón de enviar sin llenar el email
        await tester.tap(find.byKey(const Key('submitButton')));

        // Esperar a que aparezca el SnackBar
        await tester.pumpAndSettle();

        // Verificar que el ScaffoldMessenger muestra el SnackBar de error
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Error al enviar el formulario'), findsOneWidget);
      },
    );
  });
}
