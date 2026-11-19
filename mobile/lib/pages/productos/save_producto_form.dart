import 'dart:io';
import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/global/config.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaveProductoForm extends StatelessWidget {
  const SaveProductoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final productoProvider = Provider.of<ProductoProvider>(context);
    final precioXGrupoProvider = Provider.of<PrecioXGrupoProvider>(context);
    final imagenProvider = Provider.of<ImagenProvider>(context);

    //Tipos de producto - provider
    final luzProvider = Provider.of<LuzProvider>(context);

    //

    int categoria =
        productoProvider.origenFormulario!.subCategoria.categoria.id;

    Widget notifierChild;

    //Tipos de producto - ChangeNotifierProvider child
    switch (categoria) {
      case 1:
        notifierChild = _SaveProductoFormBody(
          productoProvider: productoProvider,
          precioXGrupoProvider: precioXGrupoProvider,
          imagenProvider: imagenProvider,
          luzProvider: luzProvider,
        );
        break;
      default:
        notifierChild = _SaveProductoFormBody(
          productoProvider: productoProvider,
          precioXGrupoProvider: precioXGrupoProvider,
          imagenProvider: imagenProvider,
        );
        break;
    }

    return ChangeNotifierProvider(
      create: (_) {
        //Tipos de producto - FormProvider
        switch (categoria) {
          case 1:
            return ProductoFormProvider(
              producto: productoProvider.origenFormulario!,
              preciosXGrupo: precioXGrupoProvider.origenFormulario!,
              luz: luzProvider.origenFormulario!,
            );
          default:
            return ProductoFormProvider(
              producto: productoProvider.origenFormulario!,
              preciosXGrupo: precioXGrupoProvider.origenFormulario!,
            );
        }
      },
      child: notifierChild,
    );
  }
}

class _SaveProductoFormBody extends StatefulWidget {
  final ProductoProvider productoProvider;
  final PrecioXGrupoProvider precioXGrupoProvider;
  final ImagenProvider imagenProvider;

  //Tipos de producto - provider
  final LuzProvider? luzProvider;

  //

  const _SaveProductoFormBody({
    required this.productoProvider,
    required this.precioXGrupoProvider,
    required this.imagenProvider,
    this.luzProvider,
  });

  @override
  State<_SaveProductoFormBody> createState() => _SaveProductoFormBodyState();
}

class _SaveProductoFormBodyState extends State<_SaveProductoFormBody> {
  Future<String?>? _obtenerUsuarioSesion;
  String? descAnterior;
  File? imagenFile;

  @override
  void initState() {
    super.initState();
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _obtenerUsuarioSesion = loginProvider.leerIdTrabajador();
    descAnterior = widget.productoProvider.origenFormulario!.descripcion;
  }

  Future registrar(ProductoFormProvider productoFormProvider) async {
    widget.productoProvider.isLoading = true;
    String? idUsuarioSesion = await _obtenerUsuarioSesion;
    if (idUsuarioSesion != null) {
      productoFormProvider.producto.auditoria.usuarioCreacion =
          int.tryParse(idUsuarioSesion);
      //Registro de producto
      Map<String, dynamic> mapResponse = await widget.productoProvider
          .registrarProducto(productoFormProvider.producto);
      if (mapResponse["estado"] == "OK") {
        Producto resultadoProducto =
            Producto.fromJson(mapResponse['resultado']);
        //Registro de precios
        await registrarPreciosGrupo(
            resultadoProducto, productoFormProvider, idUsuarioSesion);
        //Tipos de productos - Registrando detalles adicionales en tabla bd dedicada
        await registrarDetallesTipoProd(
            resultadoProducto, productoFormProvider, idUsuarioSesion);
        if (imagenFile != null) {
          await registrarImagen(resultadoProducto, idUsuarioSesion, 'REG');
        } else {
          await procesoExitoso(resultadoProducto, 'REG');
        }
      } else {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponse["estado"]}',
          'No se pudo registrar el producto: ${mapResponse["descripcion"]}',
          null,
        );
      }
    } else {
      llamarAlertResultado(
        '❌ Hubo un Error',
        'No se pudo registrar el producto: No se reconoce usuario en sesión',
        null,
      );
    }
  }

  Future actualizar(ProductoFormProvider productoFormProvider) async {
    widget.productoProvider.isLoading = true;
    String? idUsuarioSesion = await _obtenerUsuarioSesion;
    if (idUsuarioSesion != null) {
      productoFormProvider.producto.auditoria.usuarioModificacion =
          int.tryParse(idUsuarioSesion);
      //Actualizacion de producto
      Map<String, dynamic> mapResponse = await widget.productoProvider
          .actualizarProducto(productoFormProvider.producto);
      if (mapResponse["estado"] == "OK") {
        Producto resultadoProducto =
            Producto.fromJson(mapResponse['resultado']);
        //Guardando precios
        await actualizarPreciosGrupo(productoFormProvider, idUsuarioSesion);
        //Tipos de productos - Guardando cambios de detalles adicionales en tabla bd dedicada
        await actualizarDetallesTipoProd(
            resultadoProducto, productoFormProvider, idUsuarioSesion);
        String descActual = productoFormProvider.producto.descripcion;
        bool imgPre = resultadoProducto.imagen != null;
        bool descAct = descAnterior != descActual;
        bool imgGal = imagenFile != null;
        if (imgPre && descAct && imgGal) {
          await actualizarImagen(resultadoProducto, idUsuarioSesion);
        } else if (imgPre && descAct) {
          imagenFile = await widget.imagenProvider.getImagenPrecargada(
              resultadoProducto.imagen!.secureUrlCloudinary);
          if (imagenFile != null) {
            await actualizarImagen(resultadoProducto, idUsuarioSesion);
          } else {
            llamarAlertResultado(
              '❌ Hubo un error',
              'Se actualizó el producto pero no se pudo convetir la imagen precargada a File debido a un error',
              resultadoProducto,
            );
          }
        } else if (imgPre && imgGal) {
          await actualizarImagen(resultadoProducto, idUsuarioSesion);
        } else if (imgPre) {
          await procesoExitoso(resultadoProducto, 'ACT');
        } else if (descAct && imgGal) {
          await registrarImagen(resultadoProducto, idUsuarioSesion, 'ACT');
        } else if (descAct) {
          await procesoExitoso(resultadoProducto, 'ACT');
        } else if (imgGal) {
          await registrarImagen(resultadoProducto, idUsuarioSesion, 'ACT');
        } else {
          await procesoExitoso(resultadoProducto, 'ACT');
        }
      } else {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponse["estado"]}',
          'No se pudo guardar cambios en el producto: ${mapResponse["descripcion"]}',
          null,
        );
      }
    } else {
      llamarAlertResultado(
        '❌ Hubo un Error',
        'No se pudo guardar cambios en el producto: No se reconoce usuario en sesión',
        null,
      );
    }
  }

  Future registrarPreciosGrupo(Producto resultadoProducto,
      ProductoFormProvider productoFormProvider, String idUsuarioSesion) async {
    for (var item in productoFormProvider.preciosXGrupo) {
      if (item.valorSoles > 0) {
        item.producto = resultadoProducto;
        item.auditoria.usuarioCreacion = int.tryParse(idUsuarioSesion);
        Map<String, dynamic> mapResponsePrecio =
            await widget.precioXGrupoProvider.registrarPrecioProducto(item);
        if (mapResponsePrecio["estado"] != "OK") {
          llamarAlertResultado(
            '❌ Hubo un ${mapResponsePrecio["estado"]}',
            'Se registró el producto pero no se pudo registrar el precio del grupo ${item.grupoVenta.descripcion}: ${mapResponsePrecio["descripcion"]}',
            null,
          );
          break;
        }
      }
    }
  }

  Future actualizarPreciosGrupo(
      ProductoFormProvider productoFormProvider, String idUsuarioSesion) async {
    for (var item in productoFormProvider.preciosXGrupo) {
      if (item.valorSoles > 0) {
        Map<String, dynamic> mapResponsePrecio = {};
        if (item.id == 0) {
          item.auditoria.usuarioCreacion = int.tryParse(idUsuarioSesion);
          mapResponsePrecio =
              await widget.precioXGrupoProvider.registrarPrecioProducto(item);
        } else {
          item.auditoria.usuarioModificacion = int.tryParse(idUsuarioSesion);
          mapResponsePrecio =
              await widget.precioXGrupoProvider.actualizarPrecioProducto(item);
        }
        if (mapResponsePrecio["estado"] != "OK") {
          llamarAlertResultado(
            '❌ Hubo un ${mapResponsePrecio["estado"]}',
            'Se guardaron los cambios en el producto pero no se pudo guardar los cambios en el precio del grupo ${item.grupoVenta.descripcion}: ${mapResponsePrecio["descripcion"]}',
            null,
          );
          break;
        }
      }
    }
  }

  Future registrarDetallesTipoProd(Producto resultadoProducto,
      ProductoFormProvider productoFormProvider, String idUsuarioSesion) async {
    Categoria categoria = resultadoProducto.subCategoria.categoria;
    switch (categoria.id) {
      case 1:
        productoFormProvider.luz!.producto = resultadoProducto;
        productoFormProvider.luz!.auditoria.usuarioCreacion =
            int.tryParse(idUsuarioSesion);
        Map<String, dynamic> mapResponseLuz =
            await widget.luzProvider!.registrarLuz(productoFormProvider.luz!);
        if (mapResponseLuz["estado"] != "OK") {
          llamarAlertResultado(
            '❌ Hubo un ${mapResponseLuz["estado"]}',
            'Se registró el producto pero no se pudo registrar detalles extra de su tipo ${categoria.descripcion}: ${mapResponseLuz["descripcion"]}',
            null,
          );
        }
        break;
      default:
        break;
    }
  }

  Future actualizarDetallesTipoProd(Producto resultadoProducto,
      ProductoFormProvider productoFormProvider, String idUsuarioSesion) async {
    Categoria categoria = resultadoProducto.subCategoria.categoria;
    switch (categoria.id) {
      case 1:
        productoFormProvider.luz!.auditoria.usuarioModificacion =
            int.tryParse(idUsuarioSesion);
        Map<String, dynamic> mapResponseLuz =
            await widget.luzProvider!.actualizarLuz(productoFormProvider.luz!);
        if (mapResponseLuz["estado"] != "OK") {
          llamarAlertResultado(
            '❌ Hubo un ${mapResponseLuz["estado"]}',
            'Se guardó el producto pero no se pudo guardar detalles extra de su tipo ${categoria.descripcion}: ${mapResponseLuz["descripcion"]}',
            null,
          );
        }
        break;
      default:
        break;
    }
  }

  Future registrarImagen(Producto resultadoProducto, String idUsuarioSesion,
      String proceso) async {
    //Cargar imagen Cloudinary
    Map<String, dynamic> mapResponseCargaImagen =
        await widget.imagenProvider.cargarImagenCloudinary(
      imagenFile!,
      widget.imagenProvider.formatearNombreCloudinary(
        resultadoProducto.id,
        resultadoProducto.descripcion,
      ),
      carpetaProductos,
    );
    if (mapResponseCargaImagen["estado"] == "OK") {
      String secureUrl = mapResponseCargaImagen["descripcion"];
      //Registro imagen en BD
      Map<String, dynamic> mapResponseRegistroImagen =
          await widget.imagenProvider.registrarImagen(
        Imagen(
          id: 0,
          nombreExt: widget.imagenProvider.formatearNombreBD(
            resultadoProducto.id,
            resultadoProducto.descripcion,
            secureUrl,
          ),
          idGoogleDrive: "",
          secureUrlCloudinary: secureUrl,
          auditoria: Auditoria(
            activo: true,
            usuarioCreacion: int.tryParse(idUsuarioSesion),
          ),
        ),
      );
      if (mapResponseRegistroImagen["estado"] == "OK") {
        Imagen resultadoImagen =
            Imagen.fromJson(mapResponseRegistroImagen['resultado']);
        //Asociar imagen registrada con producto registrado
        resultadoProducto.imagen = resultadoImagen;
        resultadoProducto.auditoria.usuarioModificacion =
            int.tryParse(idUsuarioSesion);
        //Actualizacion de producto
        Map<String, dynamic> mapResponseActualizar =
            await widget.productoProvider.actualizarProducto(resultadoProducto);
        if (mapResponseActualizar["estado"] == "OK") {
          await procesoExitoso(resultadoProducto, proceso);
        } else {
          if (proceso == 'REG') {
            llamarAlertResultado(
              '❌ Hubo un ${mapResponseActualizar["estado"]}',
              'Se registró el producto, se cargó la imagen y se registró la imagen en la base de datos pero no se pudo asociar la imagen con el producto: ${mapResponseActualizar["descripcion"]}',
              resultadoProducto,
            );
          } else if (proceso == 'ACT') {
            llamarAlertResultado(
              '❌ Hubo un ${mapResponseActualizar["estado"]}',
              'Se actualizó el producto, se cargó la imagen y se registró la imagen en la base de datos pero no se pudo asociar la imagen con el producto: ${mapResponseActualizar["descripcion"]}',
              resultadoProducto,
            );
          }
        }
      } else {
        if (proceso == 'REG') {
          llamarAlertResultado(
            '❌ Hubo un ${mapResponseRegistroImagen["estado"]}',
            'Se registró el producto y se cargó la imagen pero no se pudo registrar la imagen en la base de datos: ${mapResponseRegistroImagen["descripcion"]}',
            resultadoProducto,
          );
        } else if (proceso == 'ACT') {
          llamarAlertResultado(
            '❌ Hubo un ${mapResponseRegistroImagen["estado"]}',
            'Se actualizó el producto y se cargó la imagen pero no se pudo registrar la imagen en la base de datos: ${mapResponseRegistroImagen["descripcion"]}',
            resultadoProducto,
          );
        }
      }
    } else {
      if (proceso == 'REG') {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponseCargaImagen["estado"]}',
          'Se registró el producto pero no se pudo cargar la imagen en Cloudinary: ${mapResponseCargaImagen["descripcion"]}',
          resultadoProducto,
        );
      } else if (proceso == 'ACT') {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponseCargaImagen["estado"]}',
          'Se actualizó el producto pero no se pudo cargar la imagen en Cloudinary: ${mapResponseCargaImagen["descripcion"]}',
          resultadoProducto,
        );
      }
    }
  }

  Future actualizarImagen(
      Producto resultadoProducto, String idUsuarioSesion) async {
    //Cargar imagen Cloudinary
    Map<String, dynamic> mapResponseCargaImagen =
        await widget.imagenProvider.cargarImagenCloudinary(
      imagenFile!,
      widget.imagenProvider.formatearNombreCloudinary(
        resultadoProducto.id,
        resultadoProducto.descripcion,
      ),
      carpetaProductos,
    );
    if (mapResponseCargaImagen["estado"] == "OK") {
      String secureUrl = mapResponseCargaImagen["descripcion"];
      //Actualizacion imagen en bd
      Map<String, dynamic> mapResponseActualizacionImagen =
          await widget.imagenProvider.actualizarImagen(
        Imagen(
          id: resultadoProducto.imagen!.id,
          nombreExt: widget.imagenProvider.formatearNombreBD(
            resultadoProducto.id,
            resultadoProducto.descripcion,
            secureUrl,
          ),
          idGoogleDrive: "",
          secureUrlCloudinary: secureUrl,
          auditoria: Auditoria(
            activo: true,
            fechaCreacion: resultadoProducto.imagen!.auditoria.fechaCreacion,
            usuarioCreacion:
                resultadoProducto.imagen!.auditoria.usuarioCreacion,
            usuarioModificacion: int.tryParse(idUsuarioSesion),
          ),
        ),
      );
      if (mapResponseActualizacionImagen["estado"] == "OK") {
        await procesoExitoso(resultadoProducto, 'ACT');
      } else {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponseActualizacionImagen["estado"]}',
          'Se actualizó el producto y se cargó la imagen pero no se pudo actualizar la imagen en la base de datos: ${mapResponseActualizacionImagen["descripcion"]}',
          resultadoProducto,
        );
      }
    } else {
      llamarAlertResultado(
        '❌ Hubo un ${mapResponseCargaImagen["estado"]}',
        'Se actualizó el producto pero no se pudo cargar la imagen en Cloudinary: ${mapResponseCargaImagen["descripcion"]}',
        resultadoProducto,
      );
    }
  }

  Future procesoExitoso(Producto resultadoProducto, String proceso) async {
    //Refrescando Listas
    await widget.productoProvider.cargarProductos();
    await widget.precioXGrupoProvider.cargarPreciosXGrupos();
    switch (resultadoProducto.subCategoria.categoria.id) {
      case 1:
        await widget.luzProvider!.cargarLuces();
        break;
      default:
        break;
    }
    //Mostrar alerta
    if (proceso == 'REG') {
      llamarAlertResultado(
        '✔ El producto se registró correctamente',
        'Se registró el siguiente producto: ',
        resultadoProducto,
      );
    } else if (proceso == 'ACT') {
      llamarAlertResultado(
        '✔ Se guardaron los cambios en el producto correctamente',
        'Se actualizó el siguiente producto: ',
        resultadoProducto,
      );
    }
  }

  void llamarAlertResultado(
    String titulo,
    String resultado,
    Producto? producto,
  ) {
    //Cambiando estado isloading a false
    widget.productoProvider.isLoading = false;
    //Cerrando alert de confirmar
    Navigator.of(context).pop();
    //Mostrar alert de resultado
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertResultadoProducto(
        titulo: titulo,
        resultado: resultado,
        producto: producto,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productoFormProvider = Provider.of<ProductoFormProvider>(context);

    List<Widget> formRows = [];

    formRows.add(
      Bold30MayusNaranja(
        texto: productoFormProvider.producto.id == 0
            ? 'Registrando datos del Producto'
            : 'Actualizando datos del producto',
      ),
    );

    formRows.add(
      const SizedBox(
        height: 20,
      ),
    );

    formRows.addAll(
      ProductoReadonlyArgs(
        productoFormProvider.producto.subCategoria,
        productoFormProvider.producto.marca,
      ).buildRows(context),
    );

    formRows.addAll(
      ProductoFormInputGroup(productoFormProvider.producto).buildGroup(context),
    );

    int categoria = productoFormProvider.producto.subCategoria.categoria.id;

    //Tipos de producto - Inputs extra
    switch (categoria) {
      case 1:
        formRows.addAll(
          LuzFormInputGroup(productoFormProvider.luz!).buildGroup(context),
        );
        break;
      default:
        formRows.add(
          const SizedBox(
            height: 10,
          ),
        );
    }

    formRows.add(
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Precio Unidad por Grupo de Venta:',
          alineacion: TextAlign.left,
        ),
      ),
    );

    formRows.add(
      const SizedBox(
        height: 10,
      ),
    );

    formRows.addAll(
      PrecioXGrupoVentaInputGroup(
        productoFormProvider.preciosXGrupo,
      ).buildGroup(context),
    );

    formRows.add(
      const SizedBox(
        height: 10,
      ),
    );

    formRows.add(
      SeleccionarImagen(
        onSelectImage: (File? file) {
          setState(() {
            imagenFile = file;
          });
        },
      ),
    );

    formRows.add(
      const SizedBox(
        height: 20,
      ),
    );

    formRows.add(
      productoFormProvider.producto.id == 0
          ? BotonDorado(
              ancho: 280,
              icono: 'add-circle',
              texto: 'Registrar',
              ejecutar: () async {
                if (!productoFormProvider.isValidForm()) return;
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => AlertConfirmar(
                    titulo: 'Confirmar Registro',
                    pregunta: '¿Deseas registrar este producto?',
                    confirmarAction: () async => await registrar(
                      productoFormProvider,
                    ),
                  ),
                );
              },
            )
          : BotonDorado(
              ancho: 280,
              icono: 'create',
              texto: 'Guardar Cambios',
              ejecutar: () async {
                if (!productoFormProvider.isValidForm()) return;
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => AlertConfirmar(
                    titulo: 'Confirmar Actualización',
                    pregunta:
                        '¿Deseas guardar los cambios hechos en este producto?',
                    confirmarAction: () async => await actualizar(
                      productoFormProvider,
                    ),
                  ),
                );
              },
            ),
    );

    formRows.add(
      const SizedBox(
        height: 40,
      ),
    );

    return Scaffold(
      appBar: const AppBarFlorei(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Form(
            key: productoFormProvider.formKey,
            child: Column(
              children: formRows,
            ),
          ),
        ),
      ),
    );
  }
}
