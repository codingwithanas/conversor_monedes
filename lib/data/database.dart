import 'package:hive/hive.dart';
import 'package:conversor_monedes/page/conversion.dart'; 
class Database {
  static Box? _box;

  static Future<void> init() async {
    _box = await Hive.openBox('conversionesBox');
  }

  static Future<void> guardarConversion(Conversion conversion) async {
    await _box?.add(conversion.toMap());
  }

  static List<Conversion> leerConversiones() {
    return _box?.values.map((e) => Conversion.fromMap(e)).toList() ?? [];
  }
  
  static Future<void> borrarConversion(int key) async {
    await _box?.delete(key);
  }
}
