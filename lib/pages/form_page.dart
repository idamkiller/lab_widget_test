import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

final formKey = GlobalKey<FormState>();

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('appBar'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Formulario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  key: const Key('nameField'),
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su nombre';
                    }
                    return null;
                  },
                  initialValue: 'Nombre de prueba',
                ),
                TextFormField(
                  key: const Key('emailField'),
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su email';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  key: const Key('submitButton'),
                  onPressed: () {
                    final snackBar =
                        formKey.currentState!.validate()
                            ? SnackBar(
                              key: const Key('success_snackbar'),
                              content: const Text('Formulario enviado'),
                              duration: const Duration(seconds: 4),
                              behavior: SnackBarBehavior.floating,
                            )
                            : SnackBar(
                              key: const Key('error_snackbar'),
                              content: const Text(
                                'Error al enviar el formulario',
                              ),
                              duration: const Duration(seconds: 4),
                              behavior: SnackBarBehavior.floating,
                            );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  },
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
