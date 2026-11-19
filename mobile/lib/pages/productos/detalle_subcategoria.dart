import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetalleSubCategoria extends StatelessWidget {
  const DetalleSubCategoria({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SubCategoria;

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
                texto: 'Editar Categoria',
                ejecutar: () {
                  _irAEdicionSubcategoria(
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

  Widget getDetalleCard(BuildContext context, SubCategoria subcategoria) {
    return SubCategoriaDetalleCard(
      subcategoria: subcategoria,
    );
  }

  _irAEdicionSubcategoria(
    BuildContext context,
    SubCategoria subcategoria,
  ) {
    final subcategoriaProvider = Provider.of<SubCategoriaProvider>(
      context,
      listen: false,
    );

    subcategoriaProvider.origenFormulario = subcategoria;

    Navigator.pushNamed(
      context,
      'save_subcategoria_form',
    );
  }
}
