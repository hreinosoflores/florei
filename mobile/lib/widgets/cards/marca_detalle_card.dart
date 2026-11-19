import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MarcaDetalleCard extends StatelessWidget {
  final Marca marca;

  const MarcaDetalleCard({
    super.key,
    required this.marca,
  });

  @override
  Widget build(BuildContext context) {
    Imagen? img = marca.imagen;
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
      MarcaDetalleCardInfo(marca: marca).buildRows(context),
    );
    rows.addAll(
      ImagenDetalleCardInfo(imagen: marca.imagen).buildRows(context),
    );
    rows.add(
      const SizedBox(
        height: 30,
      ),
    );
    rows.add(
      AuditoriaInfo(auditoria: marca.auditoria),
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
