import 'dart:collection';
import 'dart:convert';
import 'package:florei_movil/global/config.dart';
import 'package:florei_movil/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubCategoriaProvider extends ChangeNotifier {
  final List<SubCategoria> _subcategorias = [];
  String _searchString = "";
  bool _isLoading = false;
  SubCategoria? origenFormulario;

  String get searchString => _searchString;
  set searchString(String value) {
    _searchString = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  UnmodifiableListView<SubCategoria> get subcategorias => _searchString.isEmpty
      ? UnmodifiableListView(_subcategorias)
      : UnmodifiableListView(
          _subcategorias.where(
            (subcat) => subcat.descripcion.toUpperCase().contains(
                  _searchString.toUpperCase(),
                ),
          ),
        );

  limpiarData() {
    _searchString = "";
    _subcategorias.clear();
  }

  Future cargarSubCategorias() async {
    limpiarData();
    final url = Uri.parse("${urlApi}subcategoria");
    try {
      final resp = await http.get(url);
      final Map<String, dynamic> respDecoded =
          json.decode(utf8.decode(resp.bodyBytes));

      _subcategorias.addAll(
        subcategoriasFromJson(
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

  Future<Map<String, dynamic>> registrarSubCategoria(
      SubCategoria request) async {
    final url = Uri.parse("${urlApi}subcategoria");
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

  Future<Map<String, dynamic>> actualizarSubCategoria(
      SubCategoria request) async {
    final url = Uri.parse("${urlApi}subcategoria");
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
