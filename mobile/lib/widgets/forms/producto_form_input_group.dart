import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductoFormInputGroup {
  Producto producto;

  ProductoFormInputGroup(this.producto);

  List<Widget> buildGroup(BuildContext context) {
    return [
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Descripción',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: InputForm(
          valorInicial: producto.descripcion,
          cambiando: (value) => producto.descripcion = value,
          validando: (value) {
            if (value == null || value.isEmpty) {
              return 'Descripción Obligatorio';
            } else if (value.length <= 3) {
              return '3 letras como mínimo';
            }
            return null;
          },
          formateoLista: [
            FilteringTextInputFormatter.allow(
              RegExp(r'[^\.\#\*\$\%\&\|\°\{\}\[\]\?\¡\¿\!\/\=\+\\]+'),
            ),
          ],
          placeholder: 'Usar MAYÚSCULAS..',
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Cantidad x Caja',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: InputForm(
          valorInicial:
              producto.cantidadxCaja != null ? '${producto.cantidadxCaja}' : '',
          cambiando: (value) => producto.cantidadxCaja = int.tryParse(value),
          validando: (value) => null,
          tipoTeclado: TextInputType.number,
          formateoLista: [
            FilteringTextInputFormatter.allow(
              RegExp(r'(\d+)?'),
            ),
          ],
          placeholder: 'Cantidad en unidades de producto..',
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Stock Actual Disponible',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: InputForm(
          valorInicial:
              producto.stockActual != 0 ? '${producto.stockActual}' : '',
          cambiando: (value) {
            if (int.tryParse(value) == null) {
              producto.stockActual = 0;
            } else {
              producto.stockActual = int.parse(value);
            }
          },
          validando: (value) {
            if (value == null || value.isEmpty) {
              return 'Cantidad de unidades Obligatorio';
            }
            return null;
          },
          tipoTeclado: TextInputType.number,
          formateoLista: [
            FilteringTextInputFormatter.allow(
              RegExp(r'(\d+)?'),
            ),
          ],
          placeholder: 'Cantidad en unidades de producto..',
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Peso Unidad',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: InputForm(
          valorInicial: producto.pesoUnitario != null
              ? producto.pesoUnitario!.toStringAsFixed(2)
              : '',
          cambiando: (value) => producto.pesoUnitario = double.tryParse(value),
          validando: (value) => null,
          tipoTeclado: TextInputType.number,
          formateoLista: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^(\d+)?\.?\d{0,2}'),
            ),
          ],
          placeholder: 'Peso en Kilogramos..',
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Garantía',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: InputForm(
          valorInicial: producto.garantia != null ? '${producto.garantia}' : '',
          cambiando: (value) => producto.garantia = int.tryParse(value),
          validando: (value) => null,
          tipoTeclado: TextInputType.number,
          formateoLista: [
            FilteringTextInputFormatter.allow(
              RegExp(r'(\d+)?'),
            ),
          ],
          placeholder: 'Duración garantía en meses..',
        ),
      ),
    ];
  }
}
