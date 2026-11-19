import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProductoDetalleCardInfo {
  final Producto producto;

  const ProductoDetalleCardInfo({
    required this.producto,
  });

  List<Widget> buildRows(BuildContext context) {
    Marca? marca = producto.marca;
    String cantidadXcajaStr = producto.cantidadxCaja != null
        ? producto.cantidadxCaja! > 0
            ? producto.cantidadxCaja! == 1
                ? '1 unidad'
                : '${producto.cantidadxCaja!} unidades'
            : 'Sin datos'
        : 'Sin Datos';
    String stockStr = producto.stockActual > 0
        ? producto.stockActual == 1
            ? '1 unidad actualmente disponible'
            : '${producto.stockActual} unidades actualmente disponibles'
        : 'Producto Agotado';
    String pesoUnitStr = producto.pesoUnitario != null
        ? producto.pesoUnitario! > 0
            ? '${producto.pesoUnitario!.toStringAsFixed(2)} Kgs.'
            : 'Sin Datos'
        : 'Sin Datos';
    String garantiaStr = producto.garantia != null
        ? producto.garantia! > 0
            ? producto.garantia! / 12 == 1
                ? '1 año'
                : producto.garantia! % 12 == 0
                    ? '${producto.garantia! ~/ 12} años'
                    : '${producto.garantia!} meses'
            : 'Sin Datos'
        : 'Sin Datos';
    return [
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Código Producto:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: producto.id.toString(),
          alineacion: TextAlign.left,
        ),
      ),
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
          texto: producto.subCategoria.descripcion,
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
          texto: marca != null ? marca.descripcion : 'Sin marca',
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
          color: producto.auditoria.activo ? verdeLimo : rojo,
          texto: producto.auditoria.activo ? 'Activo' : 'Inactivo',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Cantidad x Caja:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: cantidadXcajaStr,
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Stock Actual Disponible:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: stockStr,
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Peso Unidad:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: pesoUnitStr,
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Garantía:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: garantiaStr,
          alineacion: TextAlign.left,
        ),
      ),
    ];
  }
}
