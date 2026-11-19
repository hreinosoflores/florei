import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LuzDetalleCardInfo {
  final Luz luz;

  const LuzDetalleCardInfo({
    required this.luz,
  });

  List<Widget> buildRows(BuildContext context) {
    String duracionStr = luz.duracion != null
        ? luz.duracion! > 0
            ? '${luz.duracion} horas'
            : 'Sin Datos'
        : 'Sin Datos';
    String flujoLuminosoStr = luz.flujoLuminoso != null
        ? luz.flujoLuminoso! > 0
            ? '${luz.flujoLuminoso} Lm'
            : 'Sin Datos'
        : 'Sin Datos';
    String potenciaStr = luz.potencia != null
        ? luz.potencia! > 0
            ? '${luz.potencia} W'
            : 'Sin Datos'
        : 'Sin Datos';

    return [
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Duración:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: duracionStr,
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Flujo Luminoso:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: flujoLuminosoStr,
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Potencia:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: potenciaStr,
          alineacion: TextAlign.left,
        ),
      ),
    ];
  }
}
