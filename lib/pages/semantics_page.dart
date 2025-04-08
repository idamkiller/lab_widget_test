import 'package:flutter/material.dart';

class SemanticsPage extends StatelessWidget {
  const SemanticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('appBar'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Semantics'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Semantics(
              key: const Key('semantics_button'),
              label: 'Enviar formulario',
              hint: 'Presiona para enviar el formulario',
              button: true,
              child: ElevatedButton(
                key: const Key('button'),
                onPressed: () {
                  final snackBar = SnackBar(
                    key: const Key('success_snackbar'),
                    content: const Text('Formulario enviado'),
                    duration: const Duration(seconds: 4),
                    behavior: SnackBarBehavior.floating,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: ExcludeSemantics(child: const Text('Enviar')),
              ),
            ),
            const SizedBox(height: 20),
            Semantics(
              key: const Key('semantics_text'),
              label: 'Mensaje informativo',
              readOnly: true,
              child: const ExcludeSemantics(
                child: Text(
                  'Texto de prueba',
                  key: Key('text'),
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Semantics(
              key: const Key('semantics_image'),
              label: 'Imagen decorativa de prueba',
              image: true,
              child: const ExcludeSemantics(
                child: Image(
                  key: Key('image'),
                  image: AssetImage('assets/images/150x150.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
