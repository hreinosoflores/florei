import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LuzFormInputGroup {
  Luz luz;

  LuzFormInputGroup(this.luz);

  List<Widget> buildGroup(BuildContext context) {
    return [
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Duración del Producto',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: InputForm(
          valorInicial: luz.duracion != null ? '${luz.duracion}' : '',
          cambiando: (value) => luz.duracion = int.tryParse(value),
          validando: (value) => null,
          tipoTeclado: TextInputType.number,
          formateoLista: [
            FilteringTextInputFormatter.allow(
              RegExp(r'(\d+)?'),
            ),
          ],
          placeholder: 'Duración en horas..',
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Flujo Luminoso',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: InputForm(
          valorInicial: luz.flujoLuminoso != null ? '${luz.flujoLuminoso}' : '',
          cambiando: (value) => luz.flujoLuminoso = int.tryParse(value),
          validando: (value) => null,
          tipoTeclado: TextInputType.number,
          formateoLista: [
            FilteringTextInputFormatter.allow(
              RegExp(r'(\d+)?'),
            ),
          ],
          placeholder: 'Flujo luminos en Lumens (Lm)..',
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Potencia',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: InputForm(
          valorInicial: luz.potencia != null ? '${luz.potencia}' : '',
          cambiando: (value) => luz.potencia = int.tryParse(value),
          validando: (value) => null,
          tipoTeclado: TextInputType.number,
          formateoLista: [
            FilteringTextInputFormatter.allow(
              RegExp(r'(\d+)?'),
            ),
          ],
          placeholder: 'Potencia en Watts (W)..',
        ),
      ),
    ];
  }
}
