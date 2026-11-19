import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ImagenDetalleCardInfo {
  final Imagen? imagen;

  const ImagenDetalleCardInfo({
    required this.imagen,
  });

  List<Widget> buildRows(BuildContext context) {
    String imgNombre = imagen != null ? imagen!.nombreExt : 'No Disponible';
    String imgIdDrive = imagen != null ? imagen!.idGoogleDrive : '-';
    String imgUrlCloudinary =
        imagen != null ? imagen!.secureUrlCloudinary : '-';
    return [
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Nombre Foto:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: imgNombre,
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Id Google Drive:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: imgIdDrive.isEmpty ? '-' : imgIdDrive,
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: 'Url Cloudinary:',
          alineacion: TextAlign.left,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Parrafo(
          color: negro,
          texto: imgUrlCloudinary.isEmpty ? '-' : imgUrlCloudinary,
          alineacion: TextAlign.left,
        ),
      ),
    ];
  }
}
