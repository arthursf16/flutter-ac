//INTEGRANTES: RM16505- ARTHUR SAMUEL SOUSA FERNANDES RM16644- LIA DONINI HOFMAN

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
