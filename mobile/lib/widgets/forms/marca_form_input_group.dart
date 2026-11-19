import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MarcaFormInputGroup {
  Marca marca;

  MarcaFormInputGroup(this.marca);

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
          valorInicial: marca.descripcion,
          cambiando: (value) => marca.descripcion = value,
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
