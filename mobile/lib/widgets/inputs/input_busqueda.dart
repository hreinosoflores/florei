import 'package:florei_movil/global/colors.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class InputBusqueda extends StatelessWidget {
  final TextEditingController? controlador;
  final Function cambiando;
  final String hintText;

  const InputBusqueda({
    super.key,
    this.controlador,
    required this.cambiando,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HexColor(blanco),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: HexColor(negro).withValues(alpha: (0.3 * 255)),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 18,
          color: HexColor(negro),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: HexColor(gris),
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: HexColor(gris),
          ),
          border: InputBorder.none,
        ),
        onChanged: (value) => cambiando(value),
      ),
    );
  }
}
