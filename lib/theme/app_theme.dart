import 'package:flutter/material.dart';

const _seed = Colors.deepPurple;

final lightTheme = ThemeData(colorSchemeSeed: _seed);

final darkTheme = ThemeData(
  colorSchemeSeed: _seed,
  brightness: Brightness.dark,
);
