import 'dart:convert';

import 'package:florei_movil/models/auditoria.dart';

List<GrupoVenta> gruposVentaFromJson(String str) =>
    List<GrupoVenta>.from(json.decode(str).map((x) => GrupoVenta.fromJson(x)));

String gruposVentaToJson(List<GrupoVenta> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GrupoVenta {
  GrupoVenta({
    required this.id,
    required this.descripcion,
    required this.auditoria,
  });

  int id;
  String descripcion;
  Auditoria auditoria;

  factory GrupoVenta.fromJson(Map<String, dynamic> json) => GrupoVenta(
        id: json["id"],
        descripcion: json["descripcion"],
        auditoria: Auditoria.fromJson(json["auditoria"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "auditoria": auditoria.toJson(),
      };
}
