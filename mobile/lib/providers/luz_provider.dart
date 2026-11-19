import 'dart:collection';
import 'dart:convert';
import 'package:florei_movil/global/config.dart';
import 'package:florei_movil/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LuzProvider extends ChangeNotifier {
  final List<Luz> _luces = [];
  bool _isLoading = false;
  Luz? origenFormulario;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  UnmodifiableListView<Luz> get luces => UnmodifiableListView(_luces);

  LuzProvider() {
    cargarLuces();
  }

  Future cargarLuces() async {
    _luces.clear();
    final url = Uri.parse("${urlApi}luz");
    try {
      final resp = await http.get(url);
      final Map<String, dynamic> respDecoded =
          json.decode(utf8.decode(resp.bodyBytes));
      _luces.addAll(
        lucesFromJson(
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

  Future<Map<String, dynamic>> registrarLuz(Luz request) async {
    final url = Uri.parse("${urlApi}luz");
    try {
      //throw const FormatException();
      final resp = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          request.toJson(),
        ),
      );
      return json.decode(utf8.decode(resp.bodyBytes));
    } catch (e) {
      return {
        'estado': 'Error Provider',
        'descripcion': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> actualizarLuz(Luz request) async {
    final url = Uri.parse("${urlApi}luz");
    try {
      //throw const FormatException();
      final resp = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          request.toJson(),
        ),
      );
      return json.decode(utf8.decode(resp.bodyBytes));
    } catch (e) {
      return {
        'estado': 'Error Provider',
        'descripcion': e.toString(),
      };
    }
  }
}
