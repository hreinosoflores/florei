import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProductoReadonlyArgs {
  final SubCategoria subCategoria;
  final Marca? marca;

  const ProductoReadonlyArgs(
    this.subCategoria,
    this.marca,
  );

  List<Widget> buildRows(BuildContext context) {
    return [
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Categoría:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: subCategoria.descripcion,
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Marca:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: marca != null ? marca!.descripcion : 'Sin marca',
          alineacion: TextAlign.left,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ];
  }
}
