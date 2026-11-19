import 'dart:convert';
import 'package:florei_movil/models/auditoria.dart';

List<Imagen> imagenesFromJson(String str) =>
    List<Imagen>.from(json.decode(str).map((x) => Imagen.fromJson(x)));

String imagenesToJson(List<Imagen> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Imagen {
  Imagen({
    required this.id,
    required this.nombreExt,
    required this.idGoogleDrive,
    required this.secureUrlCloudinary,
    required this.auditoria,
  });

  int id;
  String nombreExt;
  String idGoogleDrive;
  String secureUrlCloudinary;
  Auditoria auditoria;

  factory Imagen.fromJson(Map<String, dynamic> json) => Imagen(
        id: json["id"],
        nombreExt: json["nombreExt"],
        idGoogleDrive: json["idGoogleDrive"],
        secureUrlCloudinary: json["secureUrlCloudinary"],
        auditoria: Auditoria.fromJson(json["auditoria"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombreExt": nombreExt,
        "idGoogleDrive": idGoogleDrive,
        "secureUrlCloudinary": secureUrlCloudinary,
        "auditoria": auditoria.toJson(),
      };
}
