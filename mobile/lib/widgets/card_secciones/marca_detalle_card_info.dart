import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/global/config.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MarcaDetalleCardInfo {
  final Marca marca;

  const MarcaDetalleCardInfo({
    required this.marca,
  });

  List<Widget> buildRows(BuildContext context) {
    return [
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Código Marca:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: marca.id.toString(),
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Nombre Marca:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: marca.descripcion,
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Estado Actual:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: marca.auditoria.activo ? verdeLimo : rojo,
          texto: marca.auditoria.activo ? 'Activo' : 'Inactivo',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Dirección Web:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: urlWeb + marca.slug,
          alineacion: TextAlign.left,
        ),
      ),
    ];
  }
}
