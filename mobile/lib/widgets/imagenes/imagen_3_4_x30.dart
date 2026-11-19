import 'package:florei_movil/global/config.dart';
import 'package:flutter/material.dart';

class Imagen34x30 extends StatelessWidget {
  final String imagen;

  const Imagen34x30({
    super.key,
    required this.imagen,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: getImagenFromUrl(),
    );
  }

  Widget getImagenFromUrl() {
    const Image noDisponible = Image(
      image: AssetImage('assets/img/img_no_disponible.png'),
      height: 90,
      width: 120,
      fit: BoxFit.cover,
    );

    if (imagen.isNotEmpty) {
      int position = imagen.indexOf("/v");
      String imagenTransformada = imagen.substring(0, position + 1) +
          transformCloudinary +
          imagen.substring(position);

      //return noDisponible;
      return FadeInImage(
        // image: NetworkImage('$urlGDrive$imagen'),
        image: NetworkImage(imagenTransformada),
        placeholder: const AssetImage('assets/img/loading.gif'),
        height: 90,
        width: 120,
        fit: BoxFit.fill,
        imageErrorBuilder: (
          BuildContext context,
          Object exception,
          StackTrace? stackTrace,
        ) {
          return noDisponible;
        },
      );
    } else {
      return noDisponible;
    }
  }
}
