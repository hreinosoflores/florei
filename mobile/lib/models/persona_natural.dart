import 'dart:convert';
import 'package:florei_movil/models/auditoria.dart';
import 'package:florei_movil/models/persona.dart';

List<PersonaNatural> personasNaturalesFromJson(String str) =>
    List<PersonaNatural>.from(
        json.decode(str).map((x) => PersonaNatural.fromJson(x)));

String personasNaturalesToJson(List<PersonaNatural> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PersonaNatural {
  PersonaNatural({
    required this.id,
    required this.persona,
    this.dni,
    this.ruc,
    required this.nombres,
    this.apellidos,
    required this.auditoria,
  });

  int id;
  Persona persona;
  String? dni;
  String? ruc;
  String nombres;
  String? apellidos;
  Auditoria auditoria;

  factory PersonaNatural.fromJson(Map<String, dynamic> json) => PersonaNatural(
        id: json["id"],
        persona: Persona.fromJson(json["persona"]),
        dni: json["dni"],
        ruc: json["ruc"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        auditoria: Auditoria.fromJson(json["auditoria"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "persona": persona.toJson(),
        "dni": dni,
        "ruc": ruc,
        "nombres": nombres,
        "apellidos": apellidos,
        "auditoria": auditoria.toJson(),
      };
}
