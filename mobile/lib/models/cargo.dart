import 'dart:convert';

import 'package:florei_movil/models/auditoria.dart';

List<Cargo> cargosFromJson(String str) =>
    List<Cargo>.from(json.decode(str).map((x) => Cargo.fromJson(x)));

String cargosToJson(List<Cargo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cargo {
  Cargo({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.auditoria,
  });

  int id;
  String nombre;
  String descripcion;
  Auditoria auditoria;

  factory Cargo.fromJson(Map<String, dynamic> json) => Cargo(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        auditoria: Auditoria.fromJson(json["auditoria"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "auditoria": auditoria.toJson(),
      };
}
