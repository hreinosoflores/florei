import 'package:florei_movil/global/colors.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Bold30RojoTitulo extends StatelessWidget {
  final String texto;

  const Bold30RojoTitulo({
    super.key,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      maxLines: 2,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30,
        color: HexColor(rojo),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
