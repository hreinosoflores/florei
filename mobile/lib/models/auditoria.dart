class Auditoria {
  Auditoria({
    required this.activo,
    this.fechaCreacion,
    this.fechaModificacion,
    this.usuarioCreacion,
    this.usuarioModificacion,
  });

  bool activo;
  DateTime? fechaCreacion;
  DateTime? fechaModificacion;
  int? usuarioCreacion;
  int? usuarioModificacion;

  factory Auditoria.fromJson(Map<String, dynamic> json) => Auditoria(
        activo: json["activo"],
        fechaCreacion: json["fechaCreacion"] == null
            ? null
            : DateTime.parse(json["fechaCreacion"]),
        fechaModificacion: json["fechaModificacion"] == null
            ? null
            : DateTime.parse(json["fechaModificacion"]),
        usuarioCreacion: json["usuarioCreacion"],
        usuarioModificacion: json["usuarioModificacion"],
      );

  Map<String, dynamic> toJson() => {
        "activo": activo,
        "fechaCreacion": fechaCreacion?.toIso8601String(),
        "fechaModificacion": fechaModificacion?.toIso8601String(),
        "usuarioCreacion": usuarioCreacion,
        "usuarioModificacion": usuarioModificacion,
      };
}
