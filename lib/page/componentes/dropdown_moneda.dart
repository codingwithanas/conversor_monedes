import 'package:flutter/material.dart';

class DropdownMoneda extends StatelessWidget {
  final String? value;
  final Function(String?) onChanged;
  final Map<String, double> tasasDeCambio;

  DropdownMoneda({
    required this.value,
    required this.onChanged,
    required this.tasasDeCambio,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text('Selecciona una moneda'),
      value: value,
      onChanged: onChanged,
      items: tasasDeCambio.keys.map((String moneda) {
        return DropdownMenuItem<String>(
          value: moneda,
          child: Text(moneda),
        );
      }).toList(),
    );
  }
}
