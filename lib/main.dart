import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:conversor_monedes/data/database.dart';
import 'page/pagina_inicial.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Database.init(); 
  runApp(conversor_monedes());
}

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

