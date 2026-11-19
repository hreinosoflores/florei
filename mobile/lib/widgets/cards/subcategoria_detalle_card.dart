import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SubCategoriaDetalleCard extends StatelessWidget {
  final SubCategoria subcategoria;

  const SubCategoriaDetalleCard({
    super.key,
    required this.subcategoria,
  });

  @override
  Widget build(BuildContext context) {
    Imagen? img = subcategoria.imagen;
    //String imgUrl = img != null ? img.idGoogleDrive : '';
    String imgUrl = img != null ? img.secureUrlCloudinary : '';
    List<Widget> rows = [];
    rows.add(
      Imagen34x90(
        imagen: imgUrl,
      ),
    );
    rows.add(
      const SizedBox(
        height: 30,
      ),
    );
    rows.addAll(
      SubCategoriaDetalleCardInfo(subcategoria: subcategoria)
          .buildRows(context),
    );
    rows.addAll(
      ImagenDetalleCardInfo(imagen: subcategoria.imagen).buildRows(context),
    );
    rows.add(
      const SizedBox(
        height: 30,
      ),
    );
    rows.add(
      AuditoriaInfo(auditoria: subcategoria.auditoria),
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 3,
      color: HexColor(blanco),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: rows,
        ),
      ),
    );
  }
}
