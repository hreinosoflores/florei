import 'dart:convert';

import 'package:florei_movil/models/auditoria.dart';

List<Persona> personasFromJson(String str) =>
    List<Persona>.from(json.decode(str).map((x) => Persona.fromJson(x)));

String personasToJson(List<Persona> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Persona {
  Persona({
    required this.id,
    this.direccion,
    required this.auditoria,
  });

  int id;
  String? direccion;
  Auditoria auditoria;

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json["id"],
        direccion: json["direccion"],
        auditoria: Auditoria.fromJson(json["auditoria"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "direccion": direccion,
        "auditoria": auditoria.toJson(),
      };
}
