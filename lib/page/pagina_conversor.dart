import 'package:flutter/material.dart';

class PaginaConversor extends StatefulWidget {
  @override
  _PaginaConversorState createState() => _PaginaConversorState();
}

class _PaginaConversorState extends State<PaginaConversor> {
  TextEditingController controladorValorEuros = TextEditingController();
  String? monedaOrigen;
  String? monedaDestino;
  double cantidad = 0.0;

  Map<String, double> tasasDeCambio = {
    'Dólar': 1.0,
    'Euro': 0.85,
    'Libra Esterlina': 0.73,
  };
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convierte tus monedas entre el euro, dólar y libra'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.attach_money,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              'Elige el tipo de moneda y la cantidad',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            Text(
              'Escribe la cantidad en dolar'
            ),
            SizedBox(height: 20,),
            
            TextField(controller: controladorValorEuros ,),
            
          ], 
      ),
      ),
    );
  }
}