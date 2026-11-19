import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetalleProducto extends StatelessWidget {
  const DetalleProducto({super.key});

  Widget getDetalleCard(BuildContext context, Producto producto) {
    int categoria = producto.subCategoria.categoria.id;
    switch (categoria) {
      case 1:
        final luzProvider = Provider.of<LuzProvider>(
          context,
          listen: false,
        );
        List<Luz> luces = luzProvider.luces;
        Iterable<Luz> luz =
            luces.where((element) => element.producto.id == producto.id);
        if (luz.isNotEmpty) {
          return LuzDetalleCard(luz: luz.first);
        } else {
          continue prod;
        }
      prod:
      default:
        return ProductoDetalleCard(producto: producto);
    }
  }

  void irAEdicionProducto(
    BuildContext context,
    Producto producto,
    ProductoProvider productoProvider,
    GrupoVentaProvider grupoVentaProvider,
    PrecioXGrupoProvider precioXGrupoProvider,
  ) {
    List<PrecioXGrupo> preciosXGrupos = precioXGrupoProvider.preciosXGrupos;
    List<GrupoVenta> gruposVentaBD = grupoVentaProvider.gruposVenta;
    productoProvider.origenFormulario = producto;
    precioXGrupoProvider.origenFormulario = gruposVentaBD.map((gv) {
      Iterable<PrecioXGrupo> precioXGrupo = preciosXGrupos.where(
        (pg) => pg.grupoVenta.id == gv.id && pg.producto.id == producto.id,
      );
      PrecioXGrupo pg = precioXGrupo.isNotEmpty
          ? precioXGrupo.first
          : PrecioXGrupo(
              id: 0,
              grupoVenta: gv,
              producto: productoProvider.origenFormulario!,
              valorSoles: 0.0,
              auditoria: Auditoria(
                activo: true,
              ),
            );
      return pg;
    }).toList();
    //Tipos de producto - origenFormulario
    int categoria = producto.subCategoria.categoria.id;
    switch (categoria) {
      case 1:
        final luzProvider = Provider.of<LuzProvider>(
          context,
          listen: false,
        );
        List<Luz> luces = luzProvider.luces;
        Iterable<Luz> luz =
            luces.where((element) => element.producto.id == producto.id);
        if (luz.isNotEmpty) {
          luzProvider.origenFormulario = luz.first;
        }
        break;
      default:
        break;
    }
    Navigator.pushNamed(
      context,
      'save_producto_form',
    );
  }

  Future toggleActivo(
    BuildContext context,
    Producto producto,
    ProductoProvider productoProvider,
    LoginProvider loginProvider,
  ) async {
    if (await loginProvider.validarUsuarioSesion()) {
      productoProvider.isLoading = true;
      String? idUsuarioSesion = await loginProvider.leerIdTrabajador();
      if (idUsuarioSesion != null) {
        Map<String, dynamic> mapResponse = await productoProvider
            .toggleActivoProducto(idUsuarioSesion, producto.id);
        if (mapResponse["estado"] == "OK") {
          //Refrescando Listas
          await productoProvider.cargarProductos();
          //Tipos de producto - Refrescando Listas
          int categoria = producto.subCategoria.categoria.id;
          switch (categoria) {
            case 1:
              final luzProvider = Provider.of<LuzProvider>(
                context,
                listen: false,
              );
              await luzProvider.cargarLuces();
              break;
            default:
              break;
          }
          //Mostrar alerta
          llamarAlertResultado(
            context,
            productoProvider,
            '✔ Producto Actualizado',
            'Se cambió el estado del producto correctamente.',
          );
        } else {
          llamarAlertResultado(
            context,
            productoProvider,
            '❌ Hubo un ${mapResponse["estado"]}',
            'No se pudo cambiar el estado del producto: ${mapResponse["descripcion"]}',
          );
        }
      } else {
        llamarAlertResultado(
          context,
          productoProvider,
          '❌ Hubo un Error',
          'No se pudo cambiar el estado del producto: No se reconoce usuario en sesión',
        );
      }
    } else {
      Navigator.pushNamed(
        context,
        'login',
      );
    }
  }

  void llamarAlertResultado(
    BuildContext context,
    ProductoProvider productoProvider,
    String titulo,
    String resultado,
  ) {
    //Cambiando estado isloading a false
    productoProvider.isLoading = false;
    //Cerrando alert de confirmar
    Navigator.pushNamed(
      context,
      'lista_productos',
    );
    //Mostrar alert de resultado
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertResultadoProducto(
        titulo: titulo,
        resultado: resultado,
        producto: null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Producto parameter
    final args = ModalRoute.of(context)!.settings.arguments as Producto;
    //Providers
    final loginProvider = Provider.of<LoginProvider>(context);
    final productoProvider = Provider.of<ProductoProvider>(context);
    final grupoVentaProvider = Provider.of<GrupoVentaProvider>(context);
    final precioXGrupoProvider = Provider.of<PrecioXGrupoProvider>(context);

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
                texto: 'Editar Producto',
                ejecutar: () async {
                  if (await loginProvider.validarUsuarioSesion()) {
                    irAEdicionProducto(
                      context,
                      args,
                      productoProvider,
                      grupoVentaProvider,
                      precioXGrupoProvider,
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
              args.auditoria.activo
                  ? BotonRojo(
                      ancho: 280,
                      icono: 'power',
                      texto: 'Desactivar Producto',
                      ejecutar: () async => showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => AlertConfirmar(
                          titulo: 'Confirmar Desactivación',
                          pregunta:
                              '¿Deseas desactivar este producto? No aparecerá en la página web.',
                          confirmarAction: () async => await toggleActivo(
                            context,
                            args,
                            productoProvider,
                            loginProvider,
                          ),
                        ),
                      ),
                    )
                  : BotonVerde(
                      ancho: 280,
                      icono: 'power',
                      texto: 'Activar Producto',
                      ejecutar: () async => showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => AlertConfirmar(
                          titulo: 'Confirmar Activación',
                          pregunta:
                              '¿Deseas activar este producto? Volverá a aparecer todos sus datos en la página web.',
                          confirmarAction: () async => await toggleActivo(
                            context,
                            args,
                            productoProvider,
                            loginProvider,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
