import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaMarcas extends StatefulWidget {
  const ListaMarcas({super.key});

  @override
  State<ListaMarcas> createState() => _ListaMarcasState();
}

class _ListaMarcasState extends State<ListaMarcas> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final marcasProvider = Provider.of<MarcaProvider>(context, listen: false);
      await marcasProvider.cargarMarcas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarFlorei(),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const Bold30RojoTitulo(
              texto: 'Lista de Marcas',
            ),
            const SizedBox(
              height: 10,
            ),
            BotonDorado(
              ancho: 280,
              icono: 'add-circle',
              texto: 'Añadir Nueva Marca',
              ejecutar: () => _irARegistrarMarca(context),
            ),
            const SizedBox(
              height: 10,
            ),
            InputBusqueda(
              cambiando: (value) {
                final marcasProvider =
                    Provider.of<MarcaProvider>(context, listen: false);
                marcasProvider.searchString = value;
              },
              hintText: 'Nombre...',
            ),
            const SizedBox(
              height: 20,
            ),
            listaBody(),
          ],
        ),
      ),
    );
  }

  void _irARegistrarMarca(BuildContext context) {
    final marcasProvider = Provider.of<MarcaProvider>(
      context,
      listen: false,
    );
    marcasProvider.origenFormulario = Marca(
      id: 0,
      slug: '',
      descripcion: '',
      auditoria: Auditoria(
        activo: true,
      ),
    );
    Navigator.pushNamed(
      context,
      'save_marca_form',
    );
  }

  void _irADetalleMarca(
    BuildContext context,
    Marca marca,
  ) {
    Navigator.pushNamed(
      context,
      'detalle_marca',
      arguments: marca,
    );
  }

  Widget listaBody() {
    return Consumer<MarcaProvider>(
      builder: (_, marcaProvider, __) {
        List<Marca> marcas = marcaProvider.marcas;
        List<Marca> marcasOrdenado = [];
        marcasOrdenado.addAll(marcas);
        marcasOrdenado
            .sort((cat1, cat2) => cat1.descripcion.compareTo(cat2.descripcion));
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: marcasOrdenado.length,
            itemBuilder: (_, index) {
              return MarcaCard(
                marca: marcasOrdenado[index],
                registrandoProducto: false,
                ejecutar: (context) => _irADetalleMarca(
                  context,
                  marcasOrdenado[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
