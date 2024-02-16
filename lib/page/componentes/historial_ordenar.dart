// historial_ordenar.dart
import 'package:conversor_monedes/page/conversion.dart';

enum OrdenarPor { cantidad, monedaOrigen, monedaDestino, resultado }

void ordenarHistorial(List<Conversion> conversiones, OrdenarPor ordenarPor) {
  switch (ordenarPor) {
    case OrdenarPor.cantidad:
      conversiones.sort((a, b) => a.cantidad.compareTo(b.cantidad));
      break;
    case OrdenarPor.monedaOrigen:
      conversiones.sort((a, b) => a.monedaOrigen.compareTo(b.monedaOrigen));
      break;
    case OrdenarPor.monedaDestino:
      conversiones.sort((a, b) => a.monedaDestino.compareTo(b.monedaDestino));
      break;
    case OrdenarPor.resultado:
      conversiones.sort((a, b) => a.resultado.compareTo(b.resultado));
      break;
  }
}
