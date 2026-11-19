import 'dart:convert';
import 'package:florei_movil/models/auditoria.dart';
import 'package:florei_movil/models/grupo_venta.dart';
import 'package:florei_movil/models/producto.dart';

List<PrecioXGrupo> preciosXGruposFromJson(String str) =>
    List<PrecioXGrupo>.from(
        json.decode(str).map((x) => PrecioXGrupo.fromJson(x)));

String preciosXGruposToJson(List<PrecioXGrupo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PrecioXGrupo {
  PrecioXGrupo({
    required this.id,
    required this.grupoVenta,
    required this.producto,
    required this.valorSoles,
    required this.auditoria,
  });

  int id;
  GrupoVenta grupoVenta;
  Producto producto;
  double valorSoles;
  Auditoria auditoria;

  factory PrecioXGrupo.fromJson(Map<String, dynamic> json) => PrecioXGrupo(
        id: json["id"],
        grupoVenta: GrupoVenta.fromJson(json["grupoVenta"]),
        producto: Producto.fromJson(json["producto"]),
        valorSoles: json["valorSoles"].toDouble(),
        auditoria: Auditoria.fromJson(json["auditoria"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "grupoVenta": grupoVenta.toJson(),
        "producto": producto.toJson(),
        "valorSoles": valorSoles,
        "auditoria": auditoria.toJson(),
      };
}
