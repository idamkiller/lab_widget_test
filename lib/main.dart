import 'package:flutter/material.dart';
import 'package:lab_widget_test/pages/animated_page.dart';
import 'package:lab_widget_test/pages/counter_page.dart';
import 'package:lab_widget_test/pages/form_page.dart';
import 'package:lab_widget_test/pages/home_page.dart';
import 'package:lab_widget_test/pages/semantics_page.dart';
import 'package:lab_widget_test/routes.dart';
import 'package:lab_widget_test/pages/scroll_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C3AD1)),
      ),
      // Definición de rutas
      routes: {
        Routes.home: (context) => const HomePage(),
        Routes.counter:
            (context) => const CounterPage(title: 'Demo Counter Page'),
        Routes.scroll: (context) => const ScrollPage(),
        Routes.form: (context) => const FormPage(),
        Routes.semantics: (context) => const SemanticsPage(),
        Routes.animated: (context) => const AnimatedPage(),
      },
      // Definición de la ruta inicial
      initialRoute: Routes.home,
    );
  }
}
