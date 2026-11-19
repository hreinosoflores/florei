import 'dart:collection';
import 'dart:convert';
import 'package:florei_movil/global/config.dart';
import 'package:florei_movil/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TrabajadorProvider extends ChangeNotifier {
  final List<Trabajador> _trabajadores = [];

  UnmodifiableListView<Trabajador> get trabajadores =>
      UnmodifiableListView(_trabajadores);

  TrabajadorProvider() {
    cargarTrabajadores();
  }

  Future cargarTrabajadores() async {
    _trabajadores.clear();
    final url = Uri.parse("${urlApi}trabajador");
    try {
      final resp = await http.get(url);
      final Map<String, dynamic> respDecoded =
          json.decode(utf8.decode(resp.bodyBytes));
      _trabajadores.addAll(
        trabajadoresFromJson(
          json.encode(
            respDecoded['resultado'],
          ),
        ),
      );
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
