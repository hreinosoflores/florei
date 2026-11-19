import 'dart:collection';
import 'dart:convert';
import 'package:florei_movil/global/config.dart';
import 'package:florei_movil/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GrupoVentaProvider extends ChangeNotifier {
  final List<GrupoVenta> _gruposVenta = [];

  UnmodifiableListView<GrupoVenta> get gruposVenta =>
      UnmodifiableListView(_gruposVenta);

  GrupoVentaProvider() {
    cargarGruposVenta();
  }

  Future cargarGruposVenta() async {
    _gruposVenta.clear();
    final url = Uri.parse("${urlApi}grupoventa");
    try {
      final resp = await http.get(url);
      final Map<String, dynamic> respDecoded =
          json.decode(utf8.decode(resp.bodyBytes));
      _gruposVenta.addAll(
        gruposVentaFromJson(
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
