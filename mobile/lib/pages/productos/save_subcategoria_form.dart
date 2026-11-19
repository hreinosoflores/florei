import 'dart:io';
import 'package:florei_movil/global/config.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaveSubCategoriaForm extends StatelessWidget {
  const SaveSubCategoriaForm({super.key});

  @override
  Widget build(BuildContext context) {
    final subcategoriaProvider = Provider.of<SubCategoriaProvider>(context);
    final imagenProvider = Provider.of<ImagenProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => SubCategoriaFormProvider(
        subcategoria: subcategoriaProvider.origenFormulario!,
      ),
      child: _SaveSubCategoriaForm(
        subcategoriaProvider: subcategoriaProvider,
        imagenProvider: imagenProvider,
      ),
    );
  }
}

class _SaveSubCategoriaForm extends StatefulWidget {
  final SubCategoriaProvider subcategoriaProvider;
  final ImagenProvider imagenProvider;

  const _SaveSubCategoriaForm({
    required this.subcategoriaProvider,
    required this.imagenProvider,
  });

  @override
  State<_SaveSubCategoriaForm> createState() => _SaveSubCategoriaFormState();
}

class _SaveSubCategoriaFormState extends State<_SaveSubCategoriaForm> {
  Future<String?>? _obtenerUsuarioSesion;
  String? descAnterior;
  File? imagenFile;

  @override
  void initState() {
    super.initState();
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _obtenerUsuarioSesion = loginProvider.leerIdTrabajador();
    descAnterior = widget.subcategoriaProvider.origenFormulario!.descripcion;
  }

  Future registrar(SubCategoriaFormProvider subcategoriaFormProvider) async {
    widget.subcategoriaProvider.isLoading = true;
    String? idUsuarioSesion = await _obtenerUsuarioSesion;
    if (idUsuarioSesion != null) {
      subcategoriaFormProvider.subcategoria.auditoria.usuarioCreacion =
          int.tryParse(idUsuarioSesion);
      //Registro de subcategoria
      Map<String, dynamic> mapResponse = await widget.subcategoriaProvider
          .registrarSubCategoria(subcategoriaFormProvider.subcategoria);

      if (mapResponse["estado"] == "OK") {
        SubCategoria resultadoSubcategoria =
            SubCategoria.fromJson(mapResponse['resultado']);
        if (imagenFile != null) {
          await registrarImagen(resultadoSubcategoria, idUsuarioSesion, 'REG');
        } else {
          await procesoExitoso(resultadoSubcategoria, 'REG');
        }
      } else {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponse["estado"]}',
          'No se pudo registrar la categoría: ${mapResponse["descripcion"]}',
          null,
        );
      }
    } else {
      llamarAlertResultado(
        '❌ Hubo un Error',
        'No se pudo registrar la categoría: No se reconoce usuario en sesión',
        null,
      );
    }
  }

  Future actualizar(SubCategoriaFormProvider subcategoriaFormProvider) async {
    widget.subcategoriaProvider.isLoading = true;
    String? idUsuarioSesion = await _obtenerUsuarioSesion;
    if (idUsuarioSesion != null) {
      subcategoriaFormProvider.subcategoria.auditoria.usuarioModificacion =
          int.tryParse(idUsuarioSesion);
      //Actualizacion de subcategoría
      Map<String, dynamic> mapResponse = await widget.subcategoriaProvider
          .actualizarSubCategoria(subcategoriaFormProvider.subcategoria);
      if (mapResponse["estado"] == "OK") {
        SubCategoria resultadoSubcategoria =
            SubCategoria.fromJson(mapResponse['resultado']);
        String descActual = subcategoriaFormProvider.subcategoria.descripcion;
        bool imgPre = resultadoSubcategoria.imagen != null;
        bool descAct = descAnterior != descActual;
        bool imgGal = imagenFile != null;
        if (imgPre && descAct && imgGal) {
          await actualizarImagen(resultadoSubcategoria, idUsuarioSesion);
        } else if (imgPre && descAct) {
          imagenFile = await widget.imagenProvider.getImagenPrecargada(
              resultadoSubcategoria.imagen!.secureUrlCloudinary);
          if (imagenFile != null) {
            await actualizarImagen(resultadoSubcategoria, idUsuarioSesion);
          } else {
            llamarAlertResultado(
              '❌ Hubo un error',
              'Se actualizó la categoría pero no se pudo convetir la imagen precargada a File debido a un error',
              resultadoSubcategoria,
            );
          }
        } else if (imgPre && imgGal) {
          await actualizarImagen(resultadoSubcategoria, idUsuarioSesion);
        } else if (imgPre) {
          await procesoExitoso(resultadoSubcategoria, 'ACT');
        } else if (descAct && imgGal) {
          await registrarImagen(resultadoSubcategoria, idUsuarioSesion, 'ACT');
        } else if (descAct) {
          await procesoExitoso(resultadoSubcategoria, 'ACT');
        } else if (imgGal) {
          await registrarImagen(resultadoSubcategoria, idUsuarioSesion, 'ACT');
        } else {
          await procesoExitoso(resultadoSubcategoria, 'ACT');
        }
      } else {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponse["estado"]}',
          'No se pudo guardar cambios en la categoría: ${mapResponse["descripcion"]}',
          null,
        );
      }
    } else {
      llamarAlertResultado(
        '❌ Hubo un Error',
        'No se pudo registrar la categoría: No se reconoce usuario en sesión',
        null,
      );
    }
  }

  Future registrarImagen(SubCategoria resultadoSubcategoria,
      String idUsuarioSesion, String proceso) async {
    //Cargar imagen Cloudinary
    Map<String, dynamic> mapResponseCargaImagen =
        await widget.imagenProvider.cargarImagenCloudinary(
      imagenFile!,
      widget.imagenProvider.formatearNombreCloudinary(
        resultadoSubcategoria.id,
        resultadoSubcategoria.descripcion,
      ),
      carpetaSubcategorias,
    );
    if (mapResponseCargaImagen["estado"] == "OK") {
      String secureUrl = mapResponseCargaImagen["descripcion"];
      //Registro imagen en BD
      Map<String, dynamic> mapResponseRegistroImagen =
          await widget.imagenProvider.registrarImagen(
        Imagen(
          id: 0,
          nombreExt: widget.imagenProvider.formatearNombreBD(
            resultadoSubcategoria.id,
            resultadoSubcategoria.descripcion,
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
        //Asociar imagen registrada con subcategoria registrada
        resultadoSubcategoria.imagen = resultadoImagen;
        resultadoSubcategoria.auditoria.usuarioModificacion =
            int.tryParse(idUsuarioSesion);
        //Actualizacion de subcategoria
        Map<String, dynamic> mapResponseActualizar = await widget
            .subcategoriaProvider
            .actualizarSubCategoria(resultadoSubcategoria);
        if (mapResponseActualizar["estado"] == "OK") {
          await procesoExitoso(resultadoSubcategoria, proceso);
        } else {
          if (proceso == 'REG') {
            llamarAlertResultado(
              '❌ Hubo un ${mapResponseActualizar["estado"]}',
              'Se registró la categoría, se cargó la imagen y se registró la imagen en la base de datos pero no se pudo asociar la imagen con la categoría: ${mapResponseActualizar["descripcion"]}',
              resultadoSubcategoria,
            );
          } else if (proceso == 'ACT') {
            llamarAlertResultado(
              '❌ Hubo un ${mapResponseActualizar["estado"]}',
              'Se actualizó la categoría, se cargó la imagen y se registró la imagen en la base de datos pero no se pudo asociar la imagen con la categoría: ${mapResponseActualizar["descripcion"]}',
              resultadoSubcategoria,
            );
          }
        }
      } else {
        if (proceso == 'REG') {
          llamarAlertResultado(
            '❌ Hubo un ${mapResponseRegistroImagen["estado"]}',
            'Se registró la categoría y se cargó la imagen pero no se pudo registrar la imagen en la base de datos: ${mapResponseRegistroImagen["descripcion"]}',
            resultadoSubcategoria,
          );
        } else if (proceso == 'ACT') {
          llamarAlertResultado(
            '❌ Hubo un ${mapResponseRegistroImagen["estado"]}',
            'Se actualizó la categoría y se cargó la imagen pero no se pudo registrar la imagen en la base de datos: ${mapResponseRegistroImagen["descripcion"]}',
            resultadoSubcategoria,
          );
        }
      }
    } else {
      if (proceso == 'REG') {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponseCargaImagen["estado"]}',
          'Se registró la categoría pero no se pudo cargar la imagen en Cloudinary: ${mapResponseCargaImagen["descripcion"]}',
          resultadoSubcategoria,
        );
      } else if (proceso == 'ACT') {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponseCargaImagen["estado"]}',
          'Se actualizó la categoría pero no se pudo cargar la imagen en Cloudinary: ${mapResponseCargaImagen["descripcion"]}',
          resultadoSubcategoria,
        );
      }
    }
  }

  Future actualizarImagen(
      SubCategoria resultadoSubcategoria, String idUsuarioSesion) async {
    //Cargar imagen Cloudinary
    Map<String, dynamic> mapResponseCargaImagen =
        await widget.imagenProvider.cargarImagenCloudinary(
      imagenFile!,
      widget.imagenProvider.formatearNombreCloudinary(
        resultadoSubcategoria.id,
        resultadoSubcategoria.descripcion,
      ),
      carpetaSubcategorias,
    );
    if (mapResponseCargaImagen["estado"] == "OK") {
      String secureUrl = mapResponseCargaImagen["descripcion"];
      //Actualizacion imagen en bd
      Map<String, dynamic> mapResponseActualizacionImagen =
          await widget.imagenProvider.actualizarImagen(
        Imagen(
          id: resultadoSubcategoria.imagen!.id,
          nombreExt: widget.imagenProvider.formatearNombreBD(
            resultadoSubcategoria.id,
            resultadoSubcategoria.descripcion,
            secureUrl,
          ),
          idGoogleDrive: "",
          secureUrlCloudinary: secureUrl,
          auditoria: Auditoria(
            activo: true,
            fechaCreacion:
                resultadoSubcategoria.imagen!.auditoria.fechaCreacion,
            usuarioCreacion:
                resultadoSubcategoria.imagen!.auditoria.usuarioCreacion,
            usuarioModificacion: int.tryParse(idUsuarioSesion),
          ),
        ),
      );
      if (mapResponseActualizacionImagen["estado"] == "OK") {
        await procesoExitoso(resultadoSubcategoria, 'ACT');
      } else {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponseActualizacionImagen["estado"]}',
          'Se actualizó la categoría y se cargó la imagen pero no se pudo actualizar la imagen en la base de datos: ${mapResponseActualizacionImagen["descripcion"]}',
          resultadoSubcategoria,
        );
      }
    } else {
      llamarAlertResultado(
        '❌ Hubo un ${mapResponseCargaImagen["estado"]}',
        'Se actualizó la categoría pero no se pudo cargar la imagen en Cloudinary: ${mapResponseCargaImagen["descripcion"]}',
        resultadoSubcategoria,
      );
    }
  }

  Future procesoExitoso(
      SubCategoria resultadoSubcategoria, String proceso) async {
    //Refrescando listas para obtener info actualizada
    await widget.subcategoriaProvider.cargarSubCategorias();
    //Mostrar alerta
    if (proceso == 'REG') {
      llamarAlertResultado(
        '✔ La categoría se registró correctamente',
        'Se registró la siguiente categoría:',
        resultadoSubcategoria,
      );
    } else if (proceso == 'ACT') {
      llamarAlertResultado(
        '✔ Se guardaron los cambios en la categoría correctamente',
        'Se actualizó la siguiente categoría: ',
        resultadoSubcategoria,
      );
    }
  }

  void llamarAlertResultado(
    String titulo,
    String resultado,
    SubCategoria? subcategoria,
  ) {
    //Cambiando estado isloading a false
    widget.subcategoriaProvider.isLoading = false;
    //Cerrando alert de confirmar
    Navigator.of(context).pop();
    //Mostrar alert de resultado
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertResultadoSubCategoria(
        titulo: titulo,
        resultado: resultado,
        subcategoria: subcategoria,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subcategoriaFormProvider =
        Provider.of<SubCategoriaFormProvider>(context);

    List<Widget> formRows = [];

    formRows.add(
      Bold30MayusNaranja(
        texto: subcategoriaFormProvider.subcategoria.id == 0
            ? 'Registrando datos de Categoría'
            : 'Actualizando datos de Categoría',
      ),
    );

    formRows.add(
      const SizedBox(
        height: 20,
      ),
    );

    formRows.addAll(
      SubCategoriaFormInputGroup(subcategoriaFormProvider.subcategoria)
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
      subcategoriaFormProvider.subcategoria.id == 0
          ? BotonDorado(
              ancho: 280,
              icono: 'add-circle',
              texto: 'Registrar',
              ejecutar: () async {
                if (!subcategoriaFormProvider.isValidForm()) return;
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => AlertConfirmar(
                    titulo: 'Confirmar Registro',
                    pregunta: '¿Deseas registrar esta categoría?',
                    confirmarAction: () async => await registrar(
                      subcategoriaFormProvider,
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
                if (!subcategoriaFormProvider.isValidForm()) return;
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => AlertConfirmar(
                    titulo: 'Confirmar Actualización',
                    pregunta:
                        '¿Deseas guardar los cambios hechos en esta categoría?',
                    confirmarAction: () async => await actualizar(
                      subcategoriaFormProvider,
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
            key: subcategoriaFormProvider.formKey,
            child: Column(
              children: formRows,
            ),
          ),
        ),
      ),
    );
  }
}
