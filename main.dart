import 'package:flutter/material.dart';
import 'telaPrincipal.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaLocadora(),
    );
  }
}
