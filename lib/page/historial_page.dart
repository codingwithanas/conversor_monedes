// historial_page.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:conversor_monedes/data/database.dart';
import 'conversion.dart';
import 'package:conversor_monedes/page/componentes/historial_ordenar.dart';
class HistorialPage extends StatefulWidget {
  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  List<Conversion> conversiones = [];
  late Map<int, Conversion> conversionesConKey;
  OrdenarPor _ordenarPor = OrdenarPor.cantidad;
  @override
  void initState() {
    super.initState();
    cargarConversiones();
  }

  void cargarConversiones() {
    final box = Hive.box('conversionesBox');
    final tempConversiones = box.toMap().map((key, value) {
      return MapEntry(key as int, Conversion.fromMap(Map<String, dynamic>.from(value)));
    });
    setState(() {
      conversionesConKey = tempConversiones;
      conversiones = tempConversiones.values.toList();
    });
  }

  void ordenarYActualizar(OrdenarPor ordenarPor) {
    setState(() {
      _ordenarPor = ordenarPor;
      ordenarHistorial(conversiones, _ordenarPor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial de Conversiones"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Desliza un elemento hacia la izquierda o derecha para borrarlo.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => ordenarYActualizar(OrdenarPor.cantidad),
                child: Text('Cantidad'),
              ),
              ElevatedButton(
                onPressed: () => ordenarYActualizar(OrdenarPor.monedaOrigen),
                child: Text('Moneda Origen'),
              ),
              ElevatedButton(
                onPressed: () => ordenarYActualizar(OrdenarPor.monedaDestino),
                child: Text('Moneda Destino'),
              ),
              ElevatedButton(
                onPressed: () => ordenarYActualizar(OrdenarPor.resultado),
                child: Text('Resultado'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: conversiones.length,
              itemBuilder: (context, index) {
                final int key = conversionesConKey.keys.elementAt(index);
                final Conversion conv = conversionesConKey[key]!;
                return Dismissible(
                  key: Key(key.toString()),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    Database.borrarConversion(key);
                    setState(() {
                      conversionesConKey.remove(key);
                      conversiones.removeAt(index);
                    });
                  },
                  background: Container(color: Colors.red),
                  child: ListTile(
                    title: Text('${conv.cantidad} ${conv.monedaOrigen} a ${conv.monedaDestino}'),
                    subtitle: Text('Resultado: ${conv.resultado}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
