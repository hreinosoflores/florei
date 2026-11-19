import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeleccionarSubcategorias extends StatefulWidget {
  const SeleccionarSubcategorias({super.key});

  @override
  State<SeleccionarSubcategorias> createState() =>
      _SeleccionarSubcategoriasState();
}

class _SeleccionarSubcategoriasState extends State<SeleccionarSubcategorias> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final subcategoriasProvider =
          Provider.of<SubCategoriaProvider>(context, listen: false);
      await subcategoriasProvider.cargarSubCategorias();
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Categoria;

    return Scaffold(
      appBar: const AppBarFlorei(),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const Bold30MayusNaranja(
              texto: 'Seleccionar Categoría',
            ),
            const SizedBox(
              height: 10,
            ),
            BotonDorado(
              ancho: 280,
              icono: 'add-circle',
              texto: 'Añadir Nueva Categoría',
              ejecutar: () => _irARegistrarSubCategoria(context, args),
            ),
            const SizedBox(
              height: 10,
            ),
            InputBusqueda(
              cambiando: (value) {
                final subcategoriasProvider =
                    Provider.of<SubCategoriaProvider>(context, listen: false);
                subcategoriasProvider.searchString = value;
              },
              hintText: 'Nombre...',
            ),
            const SizedBox(
              height: 20,
            ),
            listaBody(args),
          ],
        ),
      ),
    );
  }

  void _irAMarcas(BuildContext context, SubCategoria subcategoria) {
    Navigator.pushNamed(
      context,
      'seleccionar_marcas',
      arguments: subcategoria,
    );
  }

  void _irARegistrarSubCategoria(BuildContext context, Categoria categoria) {
    final subcategoriasProvider = Provider.of<SubCategoriaProvider>(
      context,
      listen: false,
    );
    subcategoriasProvider.origenFormulario = SubCategoria(
      id: 0,
      categoria: categoria,
      slug: '',
      descripcion: '',
      auditoria: Auditoria(
        activo: true,
      ),
    );
    Navigator.pushNamed(
      context,
      'save_subcategoria_form',
    );
  }

  Widget listaBody(Categoria categoria) {
    return Consumer<SubCategoriaProvider>(
      builder: (_, subcategoriaProvider, __) {
        List<SubCategoria> subcategorias = subcategoriaProvider.subcategorias;
        List<SubCategoria> subcategoriasOrdenadoSoloActivos = [];
        subcategoriasOrdenadoSoloActivos.addAll(subcategorias.where((subcat) =>
            subcat.auditoria.activo && subcat.categoria.id == categoria.id));
        subcategoriasOrdenadoSoloActivos.sort((subcat1, subcat2) =>
            subcat1.descripcion.compareTo(subcat2.descripcion));
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: subcategoriasOrdenadoSoloActivos.length,
            itemBuilder: (_, index) {
              return SubCategoriaCard(
                subcategoria: subcategoriasOrdenadoSoloActivos[index],
                registrandoProducto: true,
                ejecutar: (context) => _irAMarcas(
                  context,
                  subcategoriasOrdenadoSoloActivos[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
