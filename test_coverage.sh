#!/bin/bash

# Ejecuta pruebas y genera cobertura
flutter test --coverage

# Genera el informe en HTML
genhtml coverage/lcov.info -o coverage/html

# Muestra el informe en el navegador (solo para macOS)
open coverage/html/index.html