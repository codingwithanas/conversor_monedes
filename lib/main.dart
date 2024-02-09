import 'package:flutter/material.dart';
import 'page/pagina_inicial.dart';

void main() => runApp(conversor_monedes());

class conversor_monedes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Monedas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaginaInicial(),
    );
  }
}
