import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AlertResultadoCategoria extends StatelessWidget {
  final String titulo;
  final String resultado;
  final Categoria? categoria;

  const AlertResultadoCategoria({
    super.key,
    required this.resultado,
    this.categoria,
    required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Parrafo(
        color: rojo,
        alineacion: TextAlign.center,
        texto: titulo,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: Parrafo(
              color: verdeBosque,
              alineacion: TextAlign.left,
              texto: resultado,
            ),
          ),
          categoria != null
              ? SizedBox(
                  width: double.infinity,
                  child: Parrafo(
                    color: negro,
                    alineacion: TextAlign.left,
                    texto: 'Descripción: ${categoria!.descripcion}',
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      actions: [
        BotonDoradoAlert(
          texto: 'Ok',
          ejecutar: () => Navigator.pushNamed(
            context,
            'lista_categorias',
          ),
        ),
      ],
      titlePadding: const EdgeInsets.only(
        top: 10,
        bottom: 5,
        right: 10,
        left: 10,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
    );
  }
}
