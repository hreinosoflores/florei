import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaCategorias extends StatefulWidget {
  const ListaCategorias({super.key});

  @override
  State<ListaCategorias> createState() => _ListaCategoriasState();
}

class _ListaCategoriasState extends State<ListaCategorias> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final categoriasProvider =
          Provider.of<CategoriaProvider>(context, listen: false);
      await categoriasProvider.cargarCategorias();
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
              texto: 'Lista de Tipos de Producto',
            ),
            const SizedBox(
              height: 10,
            ),
            BotonDorado(
              ancho: 280,
              icono: 'add-circle',
              texto: 'Añadir Nuevo Tipo',
              ejecutar: () => _irARegistrarCategoria(context),
            ),
            const SizedBox(
              height: 10,
            ),
            InputBusqueda(
              cambiando: (value) {
                final categoriasProvider =
                    Provider.of<CategoriaProvider>(context, listen: false);
                categoriasProvider.searchString = value;
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

  void _irARegistrarCategoria(BuildContext context) {
    final categoriasProvider = Provider.of<CategoriaProvider>(
      context,
      listen: false,
    );
    categoriasProvider.origenFormulario = Categoria(
      id: 0,
      slug: '',
      descripcion: '',
      auditoria: Auditoria(
        activo: true,
      ),
    );
    Navigator.pushNamed(
      context,
      'save_categoria_form',
    );
  }

  void _irADetalleCategoria(
    BuildContext context,
    Categoria categoria,
  ) {
    Navigator.pushNamed(
      context,
      'detalle_categoria',
      arguments: categoria,
    );
  }

  Widget listaBody() {
    return Consumer<CategoriaProvider>(
      builder: (_, categoriaProvider, __) {
        List<Categoria> categorias = categoriaProvider.categorias;
        List<Categoria> categoriasOrdenado = [];
        categoriasOrdenado.addAll(categorias);
        categoriasOrdenado
            .sort((cat1, cat2) => cat1.descripcion.compareTo(cat2.descripcion));
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: categoriasOrdenado.length,
            itemBuilder: (_, index) {
              return CategoriaCard(
                categoria: categoriasOrdenado[index],
                registrandoProducto: false,
                ejecutar: (context) => _irADetalleCategoria(
                  context,
                  categoriasOrdenado[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
