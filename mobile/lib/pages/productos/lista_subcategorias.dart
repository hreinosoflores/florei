import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaSubcategorias extends StatefulWidget {
  const ListaSubcategorias({super.key});

  @override
  State<ListaSubcategorias> createState() => _ListaSubcategoriasState();
}

class _ListaSubcategoriasState extends State<ListaSubcategorias> {
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
    return Scaffold(
      appBar: const AppBarFlorei(),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const Bold30RojoTitulo(
              texto: 'Lista de Categorías',
            ),
            const SizedBox(
              height: 10,
            ),
            BotonDorado(
              ancho: 280,
              icono: 'add-circle',
              texto: 'Añadir Nueva Categoría',
              ejecutar: () => _irARegistrarSubCategoria(context),
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
            listaBody(),
          ],
        ),
      ),
    );
  }

  void _irARegistrarSubCategoria(BuildContext context) {
    final subcategoriasProvider = Provider.of<SubCategoriaProvider>(
      context,
      listen: false,
    );
    subcategoriasProvider.origenFormulario = SubCategoria(
      id: 0,
      slug: '',
      categoria: Categoria(
        id: 0,
        descripcion: '',
        slug: '',
        auditoria: Auditoria(
          activo: true,
        ),
      ),
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

  void _irADetalleSubcategoria(
    BuildContext context,
    SubCategoria subcategoria,
  ) {
    Navigator.pushNamed(
      context,
      'detalle_subcategoria',
      arguments: subcategoria,
    );
  }

  Widget listaBody() {
    return Consumer<SubCategoriaProvider>(
      builder: (_, subcategoriaProvider, __) {
        List<SubCategoria> subcategorias = subcategoriaProvider.subcategorias;
        List<SubCategoria> subcategoriasOrdenado = [];
        subcategoriasOrdenado.addAll(subcategorias);
        subcategoriasOrdenado.sort((subcat1, subcat2) =>
            subcat1.descripcion.compareTo(subcat2.descripcion));
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: subcategoriasOrdenado.length,
            itemBuilder: (_, index) {
              return SubCategoriaCard(
                subcategoria: subcategoriasOrdenado[index],
                registrandoProducto: false,
                ejecutar: (context) => _irADetalleSubcategoria(
                  context,
                  subcategoriasOrdenado[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
