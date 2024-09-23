import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: screenSize.width * 0.10,
          right: screenSize.width * 0.10,
          bottom: 50,
          top: 50),
      child: const Text(
        "REPORTE ENCUBIERTO es un mecanismo práctico, seguro y CONFIDENCIAL para escucharte y atenderte.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
