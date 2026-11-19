import 'dart:convert';

import 'package:florei_movil/models/auditoria.dart';
import 'package:florei_movil/models/producto.dart';

List<Luz> lucesFromJson(String str) =>
    List<Luz>.from(json.decode(str).map((x) => Luz.fromJson(x)));

String lucesToJson(List<Luz> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Luz {
  Luz({
    required this.id,
    required this.producto,
    this.potencia,
    this.flujoLuminoso,
    this.duracion,
    required this.auditoria,
  });

  int id;
  Producto producto;
  int? potencia;
  int? flujoLuminoso;
  int? duracion;
  Auditoria auditoria;

  factory Luz.fromJson(Map<String, dynamic> json) => Luz(
        id: json["id"],
        producto: Producto.fromJson(json["producto"]),
        potencia: json["potencia"],
        flujoLuminoso: json["flujoLuminoso"],
        duracion: json["duracion"],
        auditoria: Auditoria.fromJson(json["auditoria"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "producto": producto.toJson(),
        "potencia": potencia,
        "flujoLuminoso": flujoLuminoso,
        "duracion": duracion,
        "auditoria": auditoria.toJson(),
      };
}
