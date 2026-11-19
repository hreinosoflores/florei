import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:florei_movil/global/config.dart';
import 'package:florei_movil/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';

class ImagenProvider extends ChangeNotifier {
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<Map<String, dynamic>> cargarImagenCloudinary(
    File imagen,
    String nombre,
    String carpeta,
  ) async {
    try {
      //throw const FormatException();
      final url = Uri.parse(urlCloudinaryPost);
      final request = http.MultipartRequest('POST', url)
        ..files.add(
          await http.MultipartFile.fromPath('file', imagen.path),
        )
        ..fields['public_id'] = nombre
        ..fields['folder'] = '$carpetaCloudinary$carpeta';
      final streamResponse = await request.send();
      final resp = await http.Response.fromStream(streamResponse);
      if (resp.statusCode != 200 && resp.statusCode != 201) {
        return {
          'estado': 'Error $resp.statusCode',
          'descripcion': 'No se cargó imagen a Cloudinary',
        };
      }
      final decodedData = json.decode(resp.body);
      return {
        'estado': 'OK',
        'descripcion': decodedData['secure_url'],
      };
    } catch (e) {
      return {
        'estado': 'Error Provider',
        'descripcion': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> registrarImagen(Imagen request) async {
    final url = Uri.parse("${urlApi}imagen");
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

  Future<Map<String, dynamic>> actualizarImagen(Imagen request) async {
    final url = Uri.parse("${urlApi}imagen");
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

  Future<File?> getImagenPrecargada(String secureURL) async {
    final url = Uri.parse(secureURL);
    try {
      //throw const FormatException();
      final resp = await http.get(url);
      Uint8List uint8list = resp.bodyBytes;
      ByteBuffer buffer = uint8list.buffer;
      ByteData byteData = ByteData.view(buffer);
      Directory tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/img').writeAsBytes(
        buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );
      return file;
    } catch (e) {
      return null;
    }
  }

  String formatearNombreCloudinary(int id, String descripcion) {
    String cadenaAleatoria = getRandomString(6).toLowerCase();
    String descripcionFormateada =
        descripcion.trim().replaceAll(RegExp(' +'), '_');
    String nuevoNombre = "${id}_${descripcionFormateada}_$cadenaAleatoria";
    return nuevoNombre;
  }

  String formatearNombreBD(int id, String descripcion, String secureUrl) {
    String extension = secureUrl.split('.').last;
    return '$id $descripcion.$extension';
  }
}
