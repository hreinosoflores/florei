import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class LuzDetalleCard extends StatefulWidget {
  final Luz luz;

  const LuzDetalleCard({
    super.key,
    required this.luz,
  });

  @override
  State<LuzDetalleCard> createState() => _LuzDetalleCardState();
}

class _LuzDetalleCardState extends State<LuzDetalleCard> {
  Future<bool>? _validarUsuarioSesion;

  @override
  void initState() {
    super.initState();
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _validarUsuarioSesion = loginProvider.validarUsuarioSesion();
  }

  @override
  Widget build(BuildContext context) {
    Imagen? img = widget.luz.producto.imagen;
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
      ProductoDetalleCardInfo(producto: widget.luz.producto).buildRows(context),
    );
    rows.addAll(
      LuzDetalleCardInfo(luz: widget.luz).buildRows(context),
    );
    rows.addAll(
      ImagenDetalleCardInfo(imagen: widget.luz.producto.imagen)
          .buildRows(context),
    );
    rows.add(
      const SizedBox(
        height: 30,
      ),
    );
    rows.add(
      TablaPreciosGrupo(producto: widget.luz.producto),
    );
    rows.add(
      const SizedBox(
        height: 30,
      ),
    );

    rows.add(
      FutureBuilder<bool>(
        future: _validarUsuarioSesion,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return AuditoriaInfo(auditoria: widget.luz.producto.auditoria);
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
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
