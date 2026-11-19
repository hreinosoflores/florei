import 'dart:convert';

import 'package:florei_movil/models/auditoria.dart';
import 'package:florei_movil/models/cargo.dart';
import 'package:florei_movil/models/persona_natural.dart';

List<Trabajador> trabajadoresFromJson(String str) =>
    List<Trabajador>.from(json.decode(str).map((x) => Trabajador.fromJson(x)));

String trabajadoresToJson(List<Trabajador> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Trabajador {
  Trabajador({
    required this.id,
    required this.peNatural,
    required this.user,
    required this.password,
    required this.cargo,
    required this.auditoria,
  });

  int id;
  PersonaNatural peNatural;
  String user;
  String password;
  Cargo cargo;
  Auditoria auditoria;

  factory Trabajador.fromJson(Map<String, dynamic> json) => Trabajador(
        id: json["id"],
        peNatural: PersonaNatural.fromJson(json["peNatural"]),
        user: json["user"],
        password: json["password"],
        cargo: Cargo.fromJson(json["cargo"]),
        auditoria: Auditoria.fromJson(json["auditoria"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "peNatural": peNatural.toJson(),
        "user": user,
        "password": password,
        "cargo": cargo.toJson(),
        "auditoria": auditoria.toJson(),
      };
}
