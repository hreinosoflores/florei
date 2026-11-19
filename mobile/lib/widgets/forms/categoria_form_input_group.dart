import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoriaFormInputGroup {
  Categoria categoria;

  CategoriaFormInputGroup(this.categoria);

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
          valorInicial: categoria.descripcion,
          cambiando: (value) => categoria.descripcion = value,
          validando: (value) {
            if (value == null || value.isEmpty) {
              return 'Nombre Obligatorio';
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
    ];
  }
}
