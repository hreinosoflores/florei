import 'package:florei_movil/global/colors.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Bold18MayusNaranja extends StatelessWidget {
  final String texto;

  const Bold18MayusNaranja({
    super.key,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      texto.toUpperCase(),
      maxLines: 2,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        color: HexColor(naranjaOscuro),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
