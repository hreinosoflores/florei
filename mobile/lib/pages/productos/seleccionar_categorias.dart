import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelecccionarCategorias extends StatefulWidget {
  const SelecccionarCategorias({super.key});

  @override
  State<SelecccionarCategorias> createState() => _SelecccionarCategoriasState();
}

class _SelecccionarCategoriasState extends State<SelecccionarCategorias> {
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
            const Bold30MayusNaranja(
              texto: '¿Qué tipo de producto deseas agregar?',
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

  void _irASubcategorias(BuildContext context, Categoria categoria) {
    Navigator.pushNamed(
      context,
      'seleccionar_subcategorias',
      arguments: categoria,
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

  Widget listaBody() {
    return Consumer<CategoriaProvider>(
      builder: (_, categoriaProvider, __) {
        List<Categoria> categorias = categoriaProvider.categorias;
        List<Categoria> categoriasOrdenadoSoloActivos = [];
        categoriasOrdenadoSoloActivos
            .addAll(categorias.where((cat) => cat.auditoria.activo));
        categoriasOrdenadoSoloActivos
            .sort((cat1, cat2) => cat1.descripcion.compareTo(cat2.descripcion));
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: categoriasOrdenadoSoloActivos.length,
            itemBuilder: (_, index) {
              return CategoriaCard(
                categoria: categoriasOrdenadoSoloActivos[index],
                registrandoProducto: true,
                ejecutar: (context) => _irASubcategorias(
                  context,
                  categoriasOrdenadoSoloActivos[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
