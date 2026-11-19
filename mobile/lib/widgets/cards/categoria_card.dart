import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CategoriaCard extends StatelessWidget {
  final Categoria categoria;
  final Function ejecutar;
  final bool registrandoProducto;

  const CategoriaCard({
    super.key,
    required this.categoria,
    required this.ejecutar,
    required this.registrandoProducto,
  });

  @override
  Widget build(BuildContext context) {
    Imagen? img = categoria.imagen;
    bool activo = categoria.auditoria.activo;
    String titulo = categoria.descripcion;
    //String imgUrl = img != null ? img.idGoogleDrive : '';
    String imgUrl = img != null ? img.secureUrlCloudinary : '';

    return GestureDetector(
      onTap: () => ejecutar(context),
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        elevation: 3,
        color: registrandoProducto
            ? HexColor(blanco)
            : HexColor(activo ? verdeLimo : rojo)
                .withValues(alpha: (0.25 * 255)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Imagen34x30(
                imagen: imgUrl,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  child: Bold18MayusNaranja(
                    texto: titulo,
                  ),
                ),
              ),
              SvgPicture.asset(
                registrandoProducto
                    ? 'assets/icons/chevron-forward-circle.svg'
                    : 'assets/icons/chevron-forward-circle.svg',
                color: HexColor(naranjaOscuro),
                width: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
