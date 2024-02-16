class Conversion {
  final String monedaOrigen;
  final String monedaDestino;
  final double cantidad;
  final double resultado;

  Conversion({
    required this.monedaOrigen,
    required this.monedaDestino,
    required this.cantidad,
    required this.resultado,
  });

  Map<String, dynamic> toMap() {
    return {
      'monedaOrigen': monedaOrigen,
      'monedaDestino': monedaDestino,
      'cantidad': cantidad,
      'resultado': resultado,
    };
  }

  factory Conversion.fromMap(Map<String, dynamic> map) {
    return Conversion(
      monedaOrigen: map['monedaOrigen'],
      monedaDestino: map['monedaDestino'],
      cantidad: map['cantidad'],
      resultado: map['resultado'],
    );
  }
}
