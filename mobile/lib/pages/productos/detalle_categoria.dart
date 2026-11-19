import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetalleCategoria extends StatelessWidget {
  const DetalleCategoria({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Categoria;

    return Scaffold(
      appBar: const AppBarFlorei(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            children: [
              Bold30MayusNaranja(
                texto: args.descripcion,
              ),
              const SizedBox(
                height: 10,
              ),
              getDetalleCard(context, args),
              const SizedBox(
                height: 20,
              ),
              BotonDorado(
                ancho: 280,
                icono: 'create',
                texto: 'Editar Tipo de Producto',
                ejecutar: () {
                  _irAEdicionCategoria(
                    context,
                    args,
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDetalleCard(BuildContext context, Categoria categoria) {
    return CategoriaDetalleCard(
      categoria: categoria,
    );
  }

  _irAEdicionCategoria(
    BuildContext context,
    Categoria categoria,
  ) {
    final categoriaProvider = Provider.of<CategoriaProvider>(
      context,
      listen: false,
    );

    categoriaProvider.origenFormulario = categoria;

    Navigator.pushNamed(
      context,
      'save_categoria_form',
    );
  }
}
