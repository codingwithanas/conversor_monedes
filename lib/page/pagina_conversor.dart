import 'package:flutter/material.dart';
import 'package:conversor_monedes/data/database.dart';
import 'conversion.dart';


class ConversorMonedas {
  static double convertir(double cantidad, double tasaOrigen, double tasaDestino) {
    return (cantidad / tasaOrigen) * tasaDestino;
  }
}

class PaginaConversor extends StatefulWidget {
  @override
  _PaginaConversorState createState() => _PaginaConversorState();
}

class _PaginaConversorState extends State<PaginaConversor> {
  String? monedaOrigen;
  String? monedaDestino;
  double cantidad = 0.0;

  Map<String, double> tasasDeCambio = {
    'Dólar': 1.0,
    'Euro': 0.85,
    'Libra Esterlina': 0.73,
  };

  void _convertirMoneda() {
  if (monedaOrigen != null && monedaDestino != null && cantidad != 0.0) {
    double tasaOrigen = tasasDeCambio[monedaOrigen]!;
    double tasaDestino = tasasDeCambio[monedaDestino]!;
    double resultado = ConversorMonedas.convertir(cantidad, tasaOrigen, tasaDestino);

    Conversion conversion = Conversion(
      monedaOrigen: monedaOrigen!,
      monedaDestino: monedaDestino!,
      cantidad: cantidad,
      resultado: resultado,
    );

    Database.guardarConversion(conversion);

    _mostrarResultado(resultado);
  } else {
    _mostrarError();
  }
}


  void _mostrarResultado(double resultado) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resultado'),
          content: Text('$cantidad $monedaOrigen equivale a $resultado $monedaDestino'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Por favor, selecciona las monedas y la cantidad.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
            SizedBox(height: 20),
            DropdownButton<String>(
              hint: Text('Moneda de Origen'),
              value: monedaOrigen,
              onChanged: (newValue) {
                setState(() {
                  monedaOrigen = newValue;
                });
              },
              items: tasasDeCambio.keys.map((String moneda) {
                return DropdownMenuItem<String>(
                  value: moneda,
                  child: Text(moneda),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              hint: Text('Moneda de Destino'),
              value: monedaDestino,
              onChanged: (newValue) {
                setState(() {
                  monedaDestino = newValue;
                });
              },
              items: tasasDeCambio.keys.map((String moneda) {
                return DropdownMenuItem<String>(
                  value: moneda,
                  child: Text(moneda),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Cantidad',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
      
                setState(() {
                  cantidad = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertirMoneda,
              child: Text(
                'Convertir',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PaginaConversor(),
  ));
}
