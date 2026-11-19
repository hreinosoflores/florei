import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertConfirmar extends StatelessWidget {
  final String titulo;
  final String pregunta;
  final Function confirmarAction;

  const AlertConfirmar({
    super.key,
    required this.pregunta,
    required this.titulo,
    required this.confirmarAction,
  });

  @override
  Widget build(BuildContext context) {
    final productoProvider = Provider.of<ProductoProvider>(context);
    final categoriaProvider = Provider.of<CategoriaProvider>(context);
    final subCategoriaProvider = Provider.of<SubCategoriaProvider>(context);
    final marcaProvider = Provider.of<MarcaProvider>(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: !productoProvider.isLoading &&
              !categoriaProvider.isLoading &&
              !subCategoriaProvider.isLoading &&
              !marcaProvider.isLoading
          ? Parrafo(
              color: rojo,
              alineacion: TextAlign.center,
              texto: titulo,
            )
          : Parrafo(
              color: rojo,
              alineacion: TextAlign.center,
              texto: 'Realizando la operación solicitada',
            ),
      content: !productoProvider.isLoading &&
              !categoriaProvider.isLoading &&
              !subCategoriaProvider.isLoading &&
              !marcaProvider.isLoading
          ? Parrafo(
              color: negro,
              alineacion: TextAlign.center,
              texto: pregunta,
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Parrafo(
                  color: negro,
                  alineacion: TextAlign.center,
                  texto:
                      'Por favor, no cierre esta aplicación hasta que finalice la tarea..',
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/img/loading.gif',
                    width: 120,
                    height: 90,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
      actions: !productoProvider.isLoading &&
              !categoriaProvider.isLoading &&
              !subCategoriaProvider.isLoading &&
              !marcaProvider.isLoading
          ? [
              BotonDoradoAlert(
                texto: 'Confirmar',
                ejecutar: () => confirmarAction(),
              ),
              BotonDoradoAlert(
                texto: 'Cancelar',
                ejecutar: () => Navigator.of(context).pop(),
              ),
            ]
          : null,
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
