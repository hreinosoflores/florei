import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/global/config.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SubCategoriaDetalleCardInfo {
  final SubCategoria subcategoria;

  const SubCategoriaDetalleCardInfo({
    required this.subcategoria,
  });

  List<Widget> buildRows(BuildContext context) {
    return [
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Código Categoría:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: subcategoria.id.toString(),
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Nombre Categoría:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: subcategoria.descripcion,
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Tipo de Producto:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: subcategoria.categoria.descripcion,
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
          color: subcategoria.auditoria.activo ? verdeLimo : rojo,
          texto: subcategoria.auditoria.activo ? 'Activo' : 'Inactivo',
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
          texto: urlWeb + subcategoria.slug,
          alineacion: TextAlign.left,
        ),
      ),
    ];
  }
}
