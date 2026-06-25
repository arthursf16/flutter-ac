import 'package:flutter/material.dart';

class BotaoCalcular extends StatelessWidget {
  final VoidCallback aoClicar;

  BotaoCalcular(this.aoClicar);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.calculate,
        size: 40,
      ),
      onPressed: aoClicar,
    );
  }
}

class BotaoFinalizar extends StatelessWidget {
  final VoidCallback aoClicar;

  BotaoFinalizar(this.aoClicar);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: aoClicar,
      child: Text("Finalizar Reserva"),
    );
  }
}
