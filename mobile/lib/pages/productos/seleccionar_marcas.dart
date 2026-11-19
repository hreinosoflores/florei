import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelecccionarMarcas extends StatefulWidget {
  const SelecccionarMarcas({super.key});

  @override
  State<SelecccionarMarcas> createState() => _SelecccionarMarcasState();
}

class _SelecccionarMarcasState extends State<SelecccionarMarcas> {
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
    final args = ModalRoute.of(context)!.settings.arguments as SubCategoria;

    List<GrupoVenta> gruposVentaBD = Provider.of<GrupoVentaProvider>(
      context,
    ).gruposVenta;

    return Scaffold(
      appBar: const AppBarFlorei(),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const Bold30MayusNaranja(
              texto: 'Seleccionar Marca',
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
            listaBody(args, gruposVentaBD),
          ],
        ),
      ),
    );
  }

  void _irARegistrarMarca(BuildContext context) {
    final marcaProvider = Provider.of<MarcaProvider>(
      context,
      listen: false,
    );
    marcaProvider.origenFormulario = Marca(
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

  void _irARegistroProducto(
    BuildContext context,
    SubCategoria subcategoria,
    Marca marca,
    List<GrupoVenta> gruposVentaBD,
  ) {
    final productoProvider = Provider.of<ProductoProvider>(
      context,
      listen: false,
    );

    final precioXGrupoProvider = Provider.of<PrecioXGrupoProvider>(
      context,
      listen: false,
    );

    productoProvider.origenFormulario = Producto(
      id: 0,
      subCategoria: subcategoria,
      marca: marca.id == 0 ? null : marca,
      descripcion: '',
      stockActual: 0,
      auditoria: Auditoria(
        activo: true,
      ),
    );

    precioXGrupoProvider.origenFormulario = gruposVentaBD
        .map(
          (gv) => PrecioXGrupo(
            id: 0,
            grupoVenta: gv,
            producto: productoProvider.origenFormulario!,
            valorSoles: 0.0,
            auditoria: Auditoria(
              activo: true,
            ),
          ),
        )
        .toList();

    int categoria = subcategoria.categoria.id;

    //Tipos de producto - origenFormulario
    switch (categoria) {
      case 1:
        final luzProvider = Provider.of<LuzProvider>(
          context,
          listen: false,
        );
        luzProvider.origenFormulario = Luz(
          id: 0,
          producto: productoProvider.origenFormulario!,
          auditoria: Auditoria(
            activo: true,
          ),
        );
        break;
      default:
        break;
    }

    Navigator.pushNamed(
      context,
      'save_producto_form',
    );
  }

  Widget listaBody(SubCategoria subcat, List<GrupoVenta> gruposVentaBD) {
    return Consumer<MarcaProvider>(
      builder: (_, marcaProvider, __) {
        List<Marca> marcas = marcaProvider.marcas;
        List<Marca> marcasOrdenadoSoloActivos = [];
        marcasOrdenadoSoloActivos
            .addAll(marcas.where((marca) => marca.auditoria.activo));
        marcasOrdenadoSoloActivos.sort((marca1, marca2) =>
            marca1.descripcion.compareTo(marca2.descripcion));
        marcasOrdenadoSoloActivos.insert(
          0,
          Marca(
            id: 0,
            descripcion: 'Sin marca',
            slug: '',
            auditoria: Auditoria(
              activo: true,
            ),
          ),
        );
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: marcasOrdenadoSoloActivos.length,
            itemBuilder: (_, index) {
              return MarcaCard(
                marca: marcasOrdenadoSoloActivos[index],
                registrandoProducto: true,
                ejecutar: (context) => _irARegistroProducto(
                  context,
                  subcat,
                  marcasOrdenadoSoloActivos[index],
                  gruposVentaBD,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
