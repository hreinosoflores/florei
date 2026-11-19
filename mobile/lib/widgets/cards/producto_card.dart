import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductoCard extends StatelessWidget {
  final Producto producto;
  final Function ejecutar;

  const ProductoCard({
    super.key,
    required this.producto,
    required this.ejecutar,
  });

  @override
  Widget build(BuildContext context) {
    Imagen? img = producto.imagen;
    int stock = producto.stockActual;
    bool activo = producto.auditoria.activo;
    String titulo = producto.descripcion;
    //String imgUrl = img != null ? img.idGoogleDrive : '';
    String imgUrl = img != null ? img.secureUrlCloudinary : '';
    String stockStr = stock > 0
        ? stock == 1
            ? '1 unidad actualmente disponible'
            : '$stock unidades actualmente disponibles'
        : 'Producto Agotado';

    return GestureDetector(
      onTap: () => ejecutar(context),
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        elevation: 3,
        color:
            HexColor(activo ? verdeLimo : rojo).withValues(alpha: (0.25 * 255)),
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
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Bold18MayusNaranja(
                        texto: titulo,
                      ),
                      Parrafo(
                        color: negro,
                        texto: stockStr,
                        alineacion: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/icons/chevron-forward-circle.svg',
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
