import 'package:flutter/material.dart';
import 'package:reporteencubiertonom035/presentacion/view/pages/home_page.dart';

class Routes extends StatelessWidget {
  const Routes({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Reporte Solicitud',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
