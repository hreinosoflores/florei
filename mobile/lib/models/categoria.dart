import 'dart:convert';

import 'package:florei_movil/models/auditoria.dart';
import 'package:florei_movil/models/imagen.dart';

List<Categoria> categoriasFromJson(String str) =>
    List<Categoria>.from(json.decode(str).map((x) => Categoria.fromJson(x)));

String categoriasToJson(List<Categoria> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categoria {
  Categoria({
    required this.id,
    required this.descripcion,
    required this.slug,
    this.imagen,
    required this.auditoria,
  });

  int id;
  String descripcion;
  String slug;
  Imagen? imagen;
  Auditoria auditoria;

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        id: json["id"],
        descripcion: json["descripcion"],
        slug: json["slug"],
        imagen: json["imagen"] == null ? null : Imagen.fromJson(json["imagen"]),
        auditoria: Auditoria.fromJson(json["auditoria"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "slug": slug,
        "imagen": imagen?.toJson(),
        "auditoria": auditoria.toJson(),
      };
}
