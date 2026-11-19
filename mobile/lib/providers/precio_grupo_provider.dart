import 'dart:collection';
import 'dart:convert';
import 'package:florei_movil/global/config.dart';
import 'package:florei_movil/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PrecioXGrupoProvider extends ChangeNotifier {
  final List<PrecioXGrupo> _preciosXGrupos = [];
  List<PrecioXGrupo>? origenFormulario;

  UnmodifiableListView<PrecioXGrupo> get preciosXGrupos =>
      UnmodifiableListView(_preciosXGrupos);

  PrecioXGrupoProvider() {
    cargarPreciosXGrupos();
  }

  Future cargarPreciosXGrupos() async {
    _preciosXGrupos.clear();
    final url = Uri.parse("${urlApi}precioxgrupo");
    try {
      final resp = await http.get(url);
      final Map<String, dynamic> respDecoded =
          json.decode(utf8.decode(resp.bodyBytes));
      _preciosXGrupos.addAll(
        preciosXGruposFromJson(
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

  Future<Map<String, dynamic>> registrarPrecioProducto(
      PrecioXGrupo request) async {
    final url = Uri.parse("${urlApi}precioxgrupo");
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

  Future<Map<String, dynamic>> actualizarPrecioProducto(
      PrecioXGrupo request) async {
    final url = Uri.parse("${urlApi}precioxgrupo");
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
