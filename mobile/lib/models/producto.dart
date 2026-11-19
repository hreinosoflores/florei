import 'dart:convert';

import 'package:florei_movil/models/auditoria.dart';
import 'package:florei_movil/models/imagen.dart';
import 'package:florei_movil/models/marca.dart';
import 'package:florei_movil/models/subcategoria.dart';

List<Producto> productosFromJson(String str) =>
    List<Producto>.from(json.decode(str).map((x) => Producto.fromJson(x)));

String productosToJson(List<Producto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Producto {
  Producto({
    required this.id,
    required this.subCategoria,
    required this.descripcion,
    this.cantidadxCaja,
    required this.stockActual,
    this.garantia,
    this.pesoUnitario,
    this.marca,
    this.imagen,
    required this.auditoria,
  });

  int id;
  SubCategoria subCategoria;
  String descripcion;
  int? cantidadxCaja;
  int stockActual;
  int? garantia;
  double? pesoUnitario;
  Marca? marca;
  Imagen? imagen;
  Auditoria auditoria;

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json["id"],
        subCategoria: SubCategoria.fromJson(json["subCategoria"]),
        descripcion: json["descripcion"],
        cantidadxCaja: json["cantidadxCaja"],
        stockActual: json["stockActual"],
        garantia: json["garantia"],
        pesoUnitario: json["pesoUnitario"],
        marca: json["marca"] == null ? null : Marca.fromJson(json["marca"]),
        imagen: json["imagen"] == null ? null : Imagen.fromJson(json["imagen"]),
        auditoria: Auditoria.fromJson(json["auditoria"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subCategoria": subCategoria.toJson(),
        "descripcion": descripcion,
        "cantidadxCaja": cantidadxCaja,
        "stockActual": stockActual,
        "garantia": garantia,
        "pesoUnitario": pesoUnitario,
        "marca": marca?.toJson(),
        "imagen": imagen?.toJson(),
        "auditoria": auditoria.toJson(),
      };
}
