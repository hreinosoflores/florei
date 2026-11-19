import 'dart:collection';
import 'dart:convert';
import 'package:florei_movil/global/config.dart';
import 'package:florei_movil/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductoProvider extends ChangeNotifier {
  final List<Producto> _productos = [];
  String _searchString = "";
  bool _isLoading = false;
  Producto? origenFormulario;

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

  UnmodifiableListView<Producto> get productos => _searchString.isEmpty
      ? UnmodifiableListView(_productos)
      : UnmodifiableListView(
          _productos.where((prod) {
            bool containsDescripcion = prod.descripcion
                .toUpperCase()
                .contains(_searchString.toUpperCase());
            bool containsMarca = prod.marca != null
                ? prod.marca!.descripcion
                    .toUpperCase()
                    .contains(_searchString.toUpperCase())
                : false;
            bool constainsSubCategoria = prod.subCategoria.descripcion
                .toUpperCase()
                .contains(_searchString.toUpperCase());
            return containsDescripcion ||
                containsMarca ||
                constainsSubCategoria;
          }),
        );

  limpiarData() {
    _searchString = "";
    _productos.clear();
  }

  Future cargarProductos() async {
    limpiarData();
    final url = Uri.parse("${urlApi}producto");
    try {
      final resp = await http.get(url);
      final Map<String, dynamic> respDecoded =
          json.decode(utf8.decode(resp.bodyBytes));
      _productos.addAll(
        productosFromJson(
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

  Future<Map<String, dynamic>> registrarProducto(Producto request) async {
    final url = Uri.parse("${urlApi}producto");
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

  Future<Map<String, dynamic>> actualizarProducto(Producto request) async {
    final url = Uri.parse("${urlApi}producto");
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

  Future<Map<String, dynamic>> toggleActivoProducto(
    String idUsuarioSesion,
    int idProd,
  ) async {
    final url = Uri.parse("${urlApi}producto/activo/$idUsuarioSesion/$idProd");
    try {
      //throw const FormatException();
      final resp = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      return json.decode(utf8.decode(resp.bodyBytes));
    } catch (e) {
      return {
        'estado': 'Error Provider',
        'descripcion': e.toString(),
      };
    }
  }

  Future registrarFake() async {
    await Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
  }
}
