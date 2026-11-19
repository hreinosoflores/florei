import 'dart:io';
import 'package:florei_movil/global/config.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaveCategoriaForm extends StatelessWidget {
  const SaveCategoriaForm({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriaProvider = Provider.of<CategoriaProvider>(context);
    final imagenProvider = Provider.of<ImagenProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => CategoriaFormProvider(
        categoria: categoriaProvider.origenFormulario!,
      ),
      child: _SaveCategoriaForm(
        categoriaProvider: categoriaProvider,
        imagenProvider: imagenProvider,
      ),
    );
  }
}

class _SaveCategoriaForm extends StatefulWidget {
  final CategoriaProvider categoriaProvider;
  final ImagenProvider imagenProvider;

  const _SaveCategoriaForm({
    required this.categoriaProvider,
    required this.imagenProvider,
  });

  @override
  State<_SaveCategoriaForm> createState() => _SaveCategoriaFormState();
}

class _SaveCategoriaFormState extends State<_SaveCategoriaForm> {
  Future<String?>? _obtenerUsuarioSesion;
  String? descAnterior;
  File? imagenFile;

  @override
  void initState() {
    super.initState();
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _obtenerUsuarioSesion = loginProvider.leerIdTrabajador();
    descAnterior = widget.categoriaProvider.origenFormulario!.descripcion;
  }

  Future registrar(CategoriaFormProvider categoriaFormProvider) async {
    widget.categoriaProvider.isLoading = true;
    String? idUsuarioSesion = await _obtenerUsuarioSesion;
    if (idUsuarioSesion != null) {
      categoriaFormProvider.categoria.auditoria.usuarioCreacion =
          int.tryParse(idUsuarioSesion);
      //Registro de categoría
      Map<String, dynamic> mapResponse = await widget.categoriaProvider
          .registrarCategoria(categoriaFormProvider.categoria);
      if (mapResponse["estado"] == "OK") {
        Categoria resultadoCategoria =
            Categoria.fromJson(mapResponse['resultado']);
        if (imagenFile != null) {
          await registrarImagen(resultadoCategoria, idUsuarioSesion, 'REG');
        } else {
          await procesoExitoso(resultadoCategoria, 'REG');
        }
      } else {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponse["estado"]}',
          'No se pudo registrar el tipo de producto: ${mapResponse["descripcion"]}',
          null,
        );
      }
    } else {
      llamarAlertResultado(
        '❌ Hubo un Error',
        'No se pudo registrar el tipo de producto: No se reconoce usuario en sesión',
        null,
      );
    }
  }

  Future actualizar(CategoriaFormProvider categoriaFormProvider) async {
    widget.categoriaProvider.isLoading = true;
    String? idUsuarioSesion = await _obtenerUsuarioSesion;
    if (idUsuarioSesion != null) {
      categoriaFormProvider.categoria.auditoria.usuarioModificacion =
          int.tryParse(idUsuarioSesion);
      //Actualizacion de categoría
      Map<String, dynamic> mapResponse = await widget.categoriaProvider
          .actualizarCategoria(categoriaFormProvider.categoria);
      if (mapResponse["estado"] == "OK") {
        Categoria resultadoCategoria =
            Categoria.fromJson(mapResponse['resultado']);
        String descActual = categoriaFormProvider.categoria.descripcion;
        bool imgPre = resultadoCategoria.imagen != null;
        bool descAct = descAnterior != descActual;
        bool imgGal = imagenFile != null;
        if (imgPre && descAct && imgGal) {
          await actualizarImagen(resultadoCategoria, idUsuarioSesion);
        } else if (imgPre && descAct) {
          imagenFile = await widget.imagenProvider.getImagenPrecargada(
              resultadoCategoria.imagen!.secureUrlCloudinary);
          if (imagenFile != null) {
            await actualizarImagen(resultadoCategoria, idUsuarioSesion);
          } else {
            llamarAlertResultado(
              '❌ Hubo un error',
              'Se actualizó el tipo de producto pero no se pudo convetir la imagen precargada a File debido a un error',
              resultadoCategoria,
            );
          }
        } else if (imgPre && imgGal) {
          await actualizarImagen(resultadoCategoria, idUsuarioSesion);
        } else if (imgPre) {
          await procesoExitoso(resultadoCategoria, 'ACT');
        } else if (descAct && imgGal) {
          await registrarImagen(resultadoCategoria, idUsuarioSesion, 'ACT');
        } else if (descAct) {
          await procesoExitoso(resultadoCategoria, 'ACT');
        } else if (imgGal) {
          await registrarImagen(resultadoCategoria, idUsuarioSesion, 'ACT');
        } else {
          await procesoExitoso(resultadoCategoria, 'ACT');
        }
      } else {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponse["estado"]}',
          'No se pudo guardar cambios en el tipo de producto: ${mapResponse["descripcion"]}',
          null,
        );
      }
    } else {
      llamarAlertResultado(
        '❌ Hubo un Error',
        'No se pudo actualizar el tipo de producto: No se reconoce usuario en sesión',
        null,
      );
    }
  }

  Future registrarImagen(Categoria resultadoCategoria, String idUsuarioSesion,
      String proceso) async {
    //Cargar imagen Cloudinary
    Map<String, dynamic> mapResponseCargaImagen =
        await widget.imagenProvider.cargarImagenCloudinary(
      imagenFile!,
      widget.imagenProvider.formatearNombreCloudinary(
        resultadoCategoria.id,
        resultadoCategoria.descripcion,
      ),
      carpetaCategorias,
    );
    if (mapResponseCargaImagen["estado"] == "OK") {
      String secureUrl = mapResponseCargaImagen["descripcion"];
      //Registro imagen en BD
      Map<String, dynamic> mapResponseRegistroImagen =
          await widget.imagenProvider.registrarImagen(
        Imagen(
          id: 0,
          nombreExt: widget.imagenProvider.formatearNombreBD(
            resultadoCategoria.id,
            resultadoCategoria.descripcion,
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
        //Asociar imagen registrada con categoria registrada
        resultadoCategoria.imagen = resultadoImagen;
        resultadoCategoria.auditoria.usuarioModificacion =
            int.tryParse(idUsuarioSesion);
        //Actualizacion de categoría
        Map<String, dynamic>? mapResponseActualizar = await widget
            .categoriaProvider
            .actualizarCategoria(resultadoCategoria);
        if (mapResponseActualizar["estado"] == "OK") {
          await procesoExitoso(resultadoCategoria, proceso);
        } else {
          if (proceso == 'REG') {
            llamarAlertResultado(
              '❌ Hubo un ${mapResponseActualizar["estado"]}',
              'Se registró el tipo de producto, se cargó la imagen y se registró la imagen en la base de datos pero no se pudo asociar la imagen con el tipo de producto: ${mapResponseActualizar["descripcion"]}',
              resultadoCategoria,
            );
          } else if (proceso == 'ACT') {
            llamarAlertResultado(
              '❌ Hubo un ${mapResponseActualizar["estado"]}',
              'Se actualizó el tipo de producto, se cargó la imagen y se registró la imagen en la base de datos pero no se pudo asociar la imagen con el tipo de producto: ${mapResponseActualizar["descripcion"]}',
              resultadoCategoria,
            );
          }
        }
      } else {
        if (proceso == 'REG') {
          llamarAlertResultado(
            '❌ Hubo un ${mapResponseRegistroImagen["estado"]}',
            'Se registró el tipo de producto y se cargó la imagen pero no se pudo registrar la imagen en la base de datos: ${mapResponseRegistroImagen["descripcion"]}',
            resultadoCategoria,
          );
        } else if (proceso == 'ACT') {
          llamarAlertResultado(
            '❌ Hubo un ${mapResponseRegistroImagen["estado"]}',
            'Se actualizó el tipo de producto y se cargó la imagen pero no se pudo registrar la imagen en la base de datos: ${mapResponseRegistroImagen["descripcion"]}',
            resultadoCategoria,
          );
        }
      }
    } else {
      if (proceso == 'REG') {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponseCargaImagen["estado"]}',
          'Se registró el tipo de producto pero no se pudo cargar la imagen en Cloudinary: ${mapResponseCargaImagen["descripcion"]}',
          resultadoCategoria,
        );
      } else if (proceso == 'ACT') {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponseCargaImagen["estado"]}',
          'Se actualizó el tipo de producto pero no se pudo cargar la imagen en Cloudinary: ${mapResponseCargaImagen["descripcion"]}',
          resultadoCategoria,
        );
      }
    }
  }

  Future actualizarImagen(
      Categoria resultadoCategoria, String idUsuarioSesion) async {
    //Cargar imagen Cloudinary
    Map<String, dynamic> mapResponseCargaImagen =
        await widget.imagenProvider.cargarImagenCloudinary(
      imagenFile!,
      widget.imagenProvider.formatearNombreCloudinary(
        resultadoCategoria.id,
        resultadoCategoria.descripcion,
      ),
      carpetaCategorias,
    );
    if (mapResponseCargaImagen["estado"] == "OK") {
      String secureUrl = mapResponseCargaImagen["descripcion"];
      //Actualizacion imagen en bd
      Map<String, dynamic> mapResponseActualizacionImagen =
          await widget.imagenProvider.actualizarImagen(
        Imagen(
          id: resultadoCategoria.imagen!.id,
          nombreExt: widget.imagenProvider.formatearNombreBD(
            resultadoCategoria.id,
            resultadoCategoria.descripcion,
            secureUrl,
          ),
          idGoogleDrive: "",
          secureUrlCloudinary: secureUrl,
          auditoria: Auditoria(
            activo: true,
            fechaCreacion: resultadoCategoria.imagen!.auditoria.fechaCreacion,
            usuarioCreacion:
                resultadoCategoria.imagen!.auditoria.usuarioCreacion,
            usuarioModificacion: int.tryParse(idUsuarioSesion),
          ),
        ),
      );
      if (mapResponseActualizacionImagen["estado"] == "OK") {
        await procesoExitoso(resultadoCategoria, 'ACT');
      } else {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponseActualizacionImagen["estado"]}',
          'Se actualizó el tipo de producto y se cargó la imagen pero no se pudo actualizar la imagen en la base de datos: ${mapResponseActualizacionImagen["descripcion"]}',
          resultadoCategoria,
        );
      }
    } else {
      llamarAlertResultado(
        '❌ Hubo un ${mapResponseCargaImagen["estado"]}',
        'Se actualizó el tipo de producto pero no se pudo cargar la imagen en Cloudinary: ${mapResponseCargaImagen["descripcion"]}',
        resultadoCategoria,
      );
    }
  }

  Future procesoExitoso(Categoria resultadoCategoria, String proceso) async {
    //Refrescando Lista
    await widget.categoriaProvider.cargarCategorias();
    //Mostrar alerta
    if (proceso == 'REG') {
      llamarAlertResultado(
        '✔ El tipo de producto se registró correctamente',
        'Se registró el siguiente tipo de producto: ',
        resultadoCategoria,
      );
    } else if (proceso == 'ACT') {
      llamarAlertResultado(
        '✔ Se guardaron los cambios en el tipo de producto correctamente',
        'Se actualizó el siguiente tipo de producto: ',
        resultadoCategoria,
      );
    }
  }

  void llamarAlertResultado(
    String titulo,
    String resultado,
    Categoria? categoria,
  ) {
    //Cambiando estado isloading a false
    widget.categoriaProvider.isLoading = false;
    //Cerrando alert de confirmar
    Navigator.of(context).pop();
    //Mostrar alert de resultado
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertResultadoCategoria(
        titulo: titulo,
        resultado: resultado,
        categoria: categoria,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoriaFormProvider = Provider.of<CategoriaFormProvider>(context);

    List<Widget> formRows = [];

    formRows.add(
      Bold30MayusNaranja(
        texto: categoriaFormProvider.categoria.id == 0
            ? 'Registrando datos de Tipo de Producto'
            : 'Actualizando datos de Tipo de Producto',
      ),
    );

    formRows.add(
      const SizedBox(
        height: 20,
      ),
    );

    formRows.addAll(
      CategoriaFormInputGroup(categoriaFormProvider.categoria)
          .buildGroup(context),
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
      categoriaFormProvider.categoria.id == 0
          ? BotonDorado(
              ancho: 280,
              icono: 'add-circle',
              texto: 'Registrar',
              ejecutar: () async {
                if (!categoriaFormProvider.isValidForm()) return;
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => AlertConfirmar(
                    titulo: 'Confirmar Registro',
                    pregunta: '¿Deseas registrar este tipo de producto?',
                    confirmarAction: () async => await registrar(
                      categoriaFormProvider,
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
                if (!categoriaFormProvider.isValidForm()) return;
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => AlertConfirmar(
                    titulo: 'Confirmar Actualización',
                    pregunta:
                        '¿Deseas guardar los cambios hechos en este tipo de producto?',
                    confirmarAction: () async => await actualizar(
                      categoriaFormProvider,
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
            key: categoriaFormProvider.formKey,
            child: Column(
              children: formRows,
            ),
          ),
        ),
      ),
    );
  }
}
