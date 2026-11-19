import 'dart:io';
import 'package:florei_movil/global/config.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaveMarcaForm extends StatelessWidget {
  const SaveMarcaForm({super.key});

  @override
  Widget build(BuildContext context) {
    final marcaProvider = Provider.of<MarcaProvider>(context);
    final imagenProvider = Provider.of<ImagenProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => MarcaFormProvider(
        marca: marcaProvider.origenFormulario!,
      ),
      child: _SaveMarcaForm(
        marcaProvider: marcaProvider,
        imagenProvider: imagenProvider,
      ),
    );
  }
}

class _SaveMarcaForm extends StatefulWidget {
  final MarcaProvider marcaProvider;
  final ImagenProvider imagenProvider;

  const _SaveMarcaForm({
    required this.marcaProvider,
    required this.imagenProvider,
  });

  @override
  State<_SaveMarcaForm> createState() => _SaveMarcaFormState();
}

class _SaveMarcaFormState extends State<_SaveMarcaForm> {
  Future<String?>? _obtenerUsuarioSesion;
  String? descAnterior;
  File? imagenFile;

  @override
  void initState() {
    super.initState();
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _obtenerUsuarioSesion = loginProvider.leerIdTrabajador();
    descAnterior = widget.marcaProvider.origenFormulario!.descripcion;
  }

  Future registrar(MarcaFormProvider marcaFormProvider) async {
    widget.marcaProvider.isLoading = true;
    String? idUsuarioSesion = await _obtenerUsuarioSesion;
    if (idUsuarioSesion != null) {
      marcaFormProvider.marca.auditoria.usuarioCreacion =
          int.tryParse(idUsuarioSesion);
      //Registro de marca
      Map<String, dynamic> mapResponse =
          await widget.marcaProvider.registrarMarca(marcaFormProvider.marca);
      if (mapResponse["estado"] == "OK") {
        Marca resultadoMarca = Marca.fromJson(mapResponse['resultado']);
        if (imagenFile != null) {
          await registrarImagen(resultadoMarca, idUsuarioSesion, 'REG');
        } else {
          await procesoExitoso(resultadoMarca, 'REG');
        }
      } else {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponse["estado"]}',
          'No se pudo registrar la marca: ${mapResponse["descripcion"]}',
          null,
        );
      }
    } else {
      llamarAlertResultado(
        '❌ Hubo un Error',
        'No se pudo registrar la marca: No se reconoce usuario en sesión',
        null,
      );
    }
  }

  Future actualizar(MarcaFormProvider marcaFormProvider) async {
    widget.marcaProvider.isLoading = true;
    String? idUsuarioSesion = await _obtenerUsuarioSesion;
    if (idUsuarioSesion != null) {
      marcaFormProvider.marca.auditoria.usuarioModificacion =
          int.tryParse(idUsuarioSesion);
      Map<String, dynamic> mapResponse =
          await widget.marcaProvider.actualizarMarca(marcaFormProvider.marca);
      if (mapResponse["estado"] == "OK") {
        Marca resultadoMarca = Marca.fromJson(mapResponse['resultado']);
        String descActual = marcaFormProvider.marca.descripcion;
        bool imgPre = resultadoMarca.imagen != null;
        bool descAct = descAnterior != descActual;
        bool imgGal = imagenFile != null;
        if (imgPre && descAct && imgGal) {
          await actualizarImagen(resultadoMarca, idUsuarioSesion);
        } else if (imgPre && descAct) {
          imagenFile = await widget.imagenProvider
              .getImagenPrecargada(resultadoMarca.imagen!.secureUrlCloudinary);
          if (imagenFile != null) {
            await actualizarImagen(resultadoMarca, idUsuarioSesion);
          } else {
            llamarAlertResultado(
              '❌ Hubo un error',
              'Se actualizó la marca pero no se pudo convetir la imagen precargada a File debido a un error',
              resultadoMarca,
            );
          }
        } else if (imgPre && imgGal) {
          await actualizarImagen(resultadoMarca, idUsuarioSesion);
        } else if (imgPre) {
          await procesoExitoso(resultadoMarca, 'ACT');
        } else if (descAct && imgGal) {
          await registrarImagen(resultadoMarca, idUsuarioSesion, 'ACT');
        } else if (descAct) {
          await procesoExitoso(resultadoMarca, 'ACT');
        } else if (imgGal) {
          await registrarImagen(resultadoMarca, idUsuarioSesion, 'ACT');
        } else {
          await procesoExitoso(resultadoMarca, 'ACT');
        }
      } else {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponse["estado"]}',
          'No se pudo guardar cambios en la marca: ${mapResponse["descripcion"]}',
          null,
        );
      }
    } else {
      llamarAlertResultado(
        '❌ Hubo un Error',
        'No se pudo actualizar la marca: No se reconoce usuario en sesión',
        null,
      );
    }
  }

  Future registrarImagen(
      Marca resultadoMarca, String idUsuarioSesion, String proceso) async {
    //Cargar imagen Cloudinary
    Map<String, dynamic> mapResponseCargaImagen =
        await widget.imagenProvider.cargarImagenCloudinary(
      imagenFile!,
      widget.imagenProvider.formatearNombreCloudinary(
        resultadoMarca.id,
        resultadoMarca.descripcion,
      ),
      carpetaMarcas,
    );
    if (mapResponseCargaImagen["estado"] == "OK") {
      String secureUrl = mapResponseCargaImagen["descripcion"];
      //Registro imagen en BD
      Map<String, dynamic> mapResponseRegistroImagen =
          await widget.imagenProvider.registrarImagen(
        Imagen(
          id: 0,
          nombreExt: widget.imagenProvider.formatearNombreBD(
            resultadoMarca.id,
            resultadoMarca.descripcion,
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
        //Asociar imagen registrada con marca registrada
        resultadoMarca.imagen = resultadoImagen;
        resultadoMarca.auditoria.usuarioModificacion =
            int.tryParse(idUsuarioSesion);
        //Actualizacion de marca
        Map<String, dynamic> mapResponseActualizar =
            await widget.marcaProvider.actualizarMarca(resultadoMarca);
        if (mapResponseActualizar["estado"] == "OK") {
          await procesoExitoso(resultadoMarca, proceso);
        } else {
          if (proceso == 'REG') {
            llamarAlertResultado(
              '❌ Hubo un ${mapResponseActualizar["estado"]}',
              'Se registró la marca, se cargó la imagen y se registró la imagen en la base de datos pero no se pudo asociar la imagen con la marca: ${mapResponseActualizar["descripcion"]}',
              resultadoMarca,
            );
          } else if (proceso == 'ACT') {
            llamarAlertResultado(
              '❌ Hubo un ${mapResponseActualizar["estado"]}',
              'Se actualizó la marca, se cargó la imagen y se registró la imagen en la base de datos pero no se pudo asociar la imagen con la marca: ${mapResponseActualizar["descripcion"]}',
              resultadoMarca,
            );
          }
        }
      } else {
        if (proceso == 'REG') {
          llamarAlertResultado(
            '❌ Hubo un ${mapResponseRegistroImagen["estado"]}',
            'Se registró la marca y se cargó la imagen pero no se pudo registrar la imagen en la base de datos: ${mapResponseRegistroImagen["descripcion"]}',
            resultadoMarca,
          );
        } else if (proceso == 'ACT') {
          llamarAlertResultado(
            '❌ Hubo un ${mapResponseRegistroImagen["estado"]}',
            'Se actualizó la marca y se cargó la imagen pero no se pudo registrar la imagen en la base de datos: ${mapResponseRegistroImagen["descripcion"]}',
            resultadoMarca,
          );
        }
      }
    } else {
      if (proceso == 'REG') {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponseCargaImagen["estado"]}',
          'Se registró la marca pero no se pudo cargar la imagen en Cloudinary: ${mapResponseCargaImagen["descripcion"]}',
          resultadoMarca,
        );
      } else if (proceso == 'ACT') {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponseCargaImagen["estado"]}',
          'Se actualizó la marca pero no se pudo cargar la imagen en Cloudinary: ${mapResponseCargaImagen["descripcion"]}',
          resultadoMarca,
        );
      }
    }
  }

  Future actualizarImagen(Marca resultadoMarca, String idUsuarioSesion) async {
    //Cargar imagen Cloudinary
    Map<String, dynamic> mapResponseCargaImagen =
        await widget.imagenProvider.cargarImagenCloudinary(
      imagenFile!,
      widget.imagenProvider.formatearNombreCloudinary(
        resultadoMarca.id,
        resultadoMarca.descripcion,
      ),
      carpetaMarcas,
    );
    if (mapResponseCargaImagen["estado"] == "OK") {
      String secureUrl = mapResponseCargaImagen["descripcion"];
      //Actualizacion imagen en bd
      Map<String, dynamic> mapResponseActualizacionImagen =
          await widget.imagenProvider.actualizarImagen(
        Imagen(
          id: resultadoMarca.imagen!.id,
          nombreExt: widget.imagenProvider.formatearNombreBD(
            resultadoMarca.id,
            resultadoMarca.descripcion,
            secureUrl,
          ),
          idGoogleDrive: "",
          secureUrlCloudinary: secureUrl,
          auditoria: Auditoria(
            activo: true,
            fechaCreacion: resultadoMarca.imagen!.auditoria.fechaCreacion,
            usuarioCreacion: resultadoMarca.imagen!.auditoria.usuarioCreacion,
            usuarioModificacion: int.tryParse(idUsuarioSesion),
          ),
        ),
      );
      if (mapResponseActualizacionImagen["estado"] == "OK") {
        await procesoExitoso(resultadoMarca, 'ACT');
      } else {
        llamarAlertResultado(
          '❌ Hubo un ${mapResponseActualizacionImagen["estado"]}',
          'Se actualizó la marca y se cargó la imagen pero no se pudo actualizar la imagen en la base de datos: ${mapResponseActualizacionImagen["descripcion"]}',
          resultadoMarca,
        );
      }
    } else {
      llamarAlertResultado(
        '❌ Hubo un ${mapResponseCargaImagen["estado"]}',
        'Se actualizó la marca pero no se pudo cargar la imagen en Cloudinary: ${mapResponseCargaImagen["descripcion"]}',
        resultadoMarca,
      );
    }
  }

  Future procesoExitoso(Marca resultadoMarca, String proceso) async {
    //Refrescando Lista
    await widget.marcaProvider.cargarMarcas();
    //Mostrar alerta
    if (proceso == 'REG') {
      llamarAlertResultado(
        '✔ La marca se registró correctamente',
        'Se registró la siguiente marca: ',
        resultadoMarca,
      );
    } else if (proceso == 'ACT') {
      llamarAlertResultado(
        '✔ Se guardaron los cambios en la marca correctamente',
        'Se actualizó la siguiente marca: ',
        resultadoMarca,
      );
    }
  }

  void llamarAlertResultado(
    String titulo,
    String resultado,
    Marca? marca,
  ) {
    //Cambiando estado isloading a false
    widget.marcaProvider.isLoading = false;
    //Cerrando alert de confirmar
    Navigator.of(context).pop();
    //Mostrar alert de resultado
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertResultadoMarca(
        titulo: titulo,
        resultado: resultado,
        marca: marca,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final marcaFormProvider = Provider.of<MarcaFormProvider>(context);

    List<Widget> formRows = [];

    formRows.add(
      Bold30MayusNaranja(
        texto: marcaFormProvider.marca.id == 0
            ? 'Registrando datos de Marca'
            : 'Actualizando datos de Marca',
      ),
    );

    formRows.add(
      const SizedBox(
        height: 20,
      ),
    );

    formRows.addAll(
      MarcaFormInputGroup(marcaFormProvider.marca).buildGroup(context),
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
      marcaFormProvider.marca.id == 0
          ? BotonDorado(
              ancho: 280,
              icono: 'add-circle',
              texto: 'Registrar',
              ejecutar: () async {
                if (!marcaFormProvider.isValidForm()) return;
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => AlertConfirmar(
                    titulo: 'Confirmar Registro',
                    pregunta: '¿Deseas registrar esta marca?',
                    confirmarAction: () async => await registrar(
                      marcaFormProvider,
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
                if (!marcaFormProvider.isValidForm()) return;
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => AlertConfirmar(
                    titulo: 'Confirmar Actualización',
                    pregunta:
                        '¿Deseas guardar los cambios hechos en esta marca?',
                    confirmarAction: () async => await actualizar(
                      marcaFormProvider,
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
            key: marcaFormProvider.formKey,
            child: Column(
              children: formRows,
            ),
          ),
        ),
      ),
    );
  }
}
