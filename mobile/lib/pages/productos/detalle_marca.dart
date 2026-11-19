import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetalleMarca extends StatelessWidget {
  const DetalleMarca({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Marca;

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
                texto: 'Editar Marca',
                ejecutar: () {
                  _irAEdicionMarca(
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

  Widget getDetalleCard(BuildContext context, Marca marca) {
    return MarcaDetalleCard(
      marca: marca,
    );
  }

  _irAEdicionMarca(
    BuildContext context,
    Marca marca,
  ) {
    final marcaProvider = Provider.of<MarcaProvider>(
      context,
      listen: false,
    );

    marcaProvider.origenFormulario = marca;

    Navigator.pushNamed(
      context,
      'save_marca_form',
    );
  }
}
