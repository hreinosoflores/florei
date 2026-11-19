import 'dart:convert';

import 'package:florei_movil/models/auditoria.dart';
import 'package:florei_movil/models/categoria.dart';
import 'package:florei_movil/models/imagen.dart';

List<SubCategoria> subcategoriasFromJson(String str) => List<SubCategoria>.from(
    json.decode(str).map((x) => SubCategoria.fromJson(x)));

String subcategoriasToJson(List<SubCategoria> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategoria {
  SubCategoria({
    required this.id,
    required this.descripcion,
    required this.slug,
    this.imagen,
    required this.categoria,
    required this.auditoria,
  });

  int id;
  String descripcion;
  String slug;
  Imagen? imagen;
  Categoria categoria;
  Auditoria auditoria;

  factory SubCategoria.fromJson(Map<String, dynamic> json) => SubCategoria(
        id: json["id"],
        descripcion: json["descripcion"],
        slug: json["slug"],
        imagen: json["imagen"] == null ? null : Imagen.fromJson(json["imagen"]),
        categoria: Categoria.fromJson(json["categoria"]),
        auditoria: Auditoria.fromJson(json["auditoria"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "slug": slug,
        "imagen": imagen?.toJson(),
        "categoria": categoria.toJson(),
        "auditoria": auditoria.toJson(),
      };
}
