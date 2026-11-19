import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Parrafo extends StatelessWidget {
  final String color;
  final String texto;
  final TextAlign alineacion;

  const Parrafo({
    super.key,
    required this.color,
    required this.texto,
    required this.alineacion,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      maxLines: 6,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      textAlign: alineacion,
      style: TextStyle(
        fontSize: 18,
        color: HexColor(color),
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
