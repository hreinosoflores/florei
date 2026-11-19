import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaProductos extends StatefulWidget {
  const ListaProductos({super.key});

  @override
  State<ListaProductos> createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final productoProvider =
          Provider.of<ProductoProvider>(context, listen: false);
      await productoProvider.cargarProductos();
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
              texto: 'Lista de Productos',
            ),
            const SizedBox(
              height: 10,
            ),
            BotonDorado(
              ancho: 280,
              icono: 'add-circle',
              texto: 'Añadir Nuevo Producto',
              ejecutar: () async {
                final loginProvider =
                    Provider.of<LoginProvider>(context, listen: false);
                if (await loginProvider.validarUsuarioSesion()) {
                  Navigator.pushNamed(
                    context,
                    'seleccionar_categorias',
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    'login',
                  );
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            InputBusqueda(
              cambiando: (value) {
                final productoProvider =
                    Provider.of<ProductoProvider>(context, listen: false);
                productoProvider.searchString = value;
              },
              hintText: 'Nombre, Categoría o Marca..',
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

  void _irADetalle(BuildContext context, Producto producto) {
    Navigator.pushNamed(
      context,
      'detalle_producto',
      arguments: producto,
    );
  }

  Widget listaBody() {
    return Consumer<ProductoProvider>(
      builder: (_, productoProvider, __) {
        List<Producto> productos = productoProvider.productos;
        List<Producto> productosOrdenado = [];
        productosOrdenado.addAll(productos);
        productosOrdenado.sort((p1, p2) => p1.id.compareTo(p2.id));
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: productos.length,
            itemBuilder: (_, index) {
              return ProductoCard(
                producto: productosOrdenado[index],
                ejecutar: (context) => _irADetalle(
                  context,
                  productosOrdenado[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
