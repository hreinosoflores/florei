import 'dart:convert';
import 'package:florei_movil/global/config.dart';
import 'package:florei_movil/models/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  Future<String?> login(String user, String password) async {
    final url = Uri.parse("${urlApi}trabajador");
    try {
      final resp = await http.get(url);
      final Map<String, dynamic> respDecoded =
          json.decode(utf8.decode(resp.bodyBytes));

      if (respDecoded["estado"] == "OK") {
        Iterable<Trabajador> trabajadoresLogueados = trabajadoresFromJson(
          json.encode(
            respDecoded['resultado'],
          ),
        ).where((trab) => trab.user == user && trab.password == password);

        if (trabajadoresLogueados.isNotEmpty) {
          Trabajador trabLogueado = trabajadoresLogueados.first;
          await storage.deleteAll();
          await storage.write(
            key: 'idTrabajador',
            value: "${trabLogueado.id}",
          );
          await storage.write(
            key: 'idPeNatural',
            value: "${trabLogueado.peNatural.id}",
          );
          await storage.write(
            key: 'idPersona',
            value: "${trabLogueado.peNatural.persona.id}",
          );
          await storage.write(
            key: 'user',
            value: trabLogueado.user,
          );
        } else {
          return "Las credenciales ingresadas no fueron encontradas en el sistema. Asegúrese de haber escrito correctamente su id de usuario y/o contraseña.";
        }
      } else {
        return respDecoded["descripcion"];
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> validarUsuarioSesion() async {
    bool containsTrabajador = await storage.containsKey(key: 'idTrabajador');
    bool containsPeNatural = await storage.containsKey(key: 'idPeNatural');
    bool containsPersona = await storage.containsKey(key: 'idPersona');
    bool containsUser = await storage.containsKey(key: 'user');
    return containsTrabajador &&
        containsPeNatural &&
        containsPersona &&
        containsUser;
  }

  Future<String?> leerIdTrabajador() async {
    return await storage.read(key: 'idTrabajador');
  }

  Future logout() async {
    await storage.deleteAll();
  }
}
