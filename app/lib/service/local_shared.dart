import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalShared with ChangeNotifier {
  bool _ordem = false;
  bool _previa = false;

  getStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool("ordem")) {
      _ordem = sharedPreferences.getBool("ordem"); 
    } else {
      _ordem = false;
    }
    if (sharedPreferences.getBool("previa")) {
      _previa = sharedPreferences.getBool("previa"); 
    } else {
      _previa = false;
    }
    notifyListeners();
  }

  get ordem => _ordem;
  get previa => _previa;

  Future setOrdemAlfabetica(String key, bool valor) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, valor);
    _ordem = valor;
    notifyListeners();
  }

  Future<bool> getExibirPrevia(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool(key)) {
      return true;
    }
    return false;
  }

  Future setExibirPrevia(String key, bool valor) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, valor);
    _previa = valor;
    notifyListeners();
  }
}
