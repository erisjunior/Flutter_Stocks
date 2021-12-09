import 'package:flutter/material.dart';
import 'package:invest/ui/home.dart';

void main() {
  // int primaryColor = 0x902060ff;

  runApp(MaterialApp(
    title: "Consulta de Ações",
    home: Home(),
    theme:
        ThemeData(hintColor: Colors.white, primaryColor: Colors.pink.shade600),
  ));
}
