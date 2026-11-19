import 'dart:collection';
import 'dart:convert';
import 'package:florei_movil/global/config.dart';
import 'package:florei_movil/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriaProvider extends ChangeNotifier {
  final List<Categoria> _categorias = [];
  String _searchString = "";
  bool _isLoading = false;
  Categoria? origenFormulario;

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

  UnmodifiableListView<Categoria> get categorias => _searchString.isEmpty
      ? UnmodifiableListView(_categorias)
      : UnmodifiableListView(
          _categorias.where(
            (categoria) => categoria.descripcion.toUpperCase().contains(
                  _searchString.toUpperCase(),
                ),
          ),
        );

  limpiarData() {
    _searchString = "";
    _categorias.clear();
  }

  Future cargarCategorias() async {
    limpiarData();
    final url = Uri.parse("${urlApi}categoria");
    try {
      final resp = await http.get(url);
      final Map<String, dynamic> respDecoded =
          json.decode(utf8.decode(resp.bodyBytes));

      _categorias.addAll(
        categoriasFromJson(
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

  Future<Map<String, dynamic>> registrarCategoria(Categoria request) async {
    final url = Uri.parse("${urlApi}categoria");
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

  Future<Map<String, dynamic>> actualizarCategoria(Categoria request) async {
    final url = Uri.parse("${urlApi}categoria");
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
