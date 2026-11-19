import 'package:florei_movil/global/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

class BotonDorado extends StatelessWidget {
  final double ancho;
  final String icono;
  final String texto;
  final Function ejecutar;
  final bool? isLoading;

  const BotonDorado(
      {super.key,
      required this.ancho,
      required this.icono,
      required this.texto,
      required this.ejecutar,
      this.isLoading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ancho,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            HexColor(dorado),
          ),
          elevation: WidgetStateProperty.all<double>(5),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onPressed: () {
          if (isLoading != null) {
            if (isLoading!) {
              return;
            }
          }

          FocusScope.of(context).unfocus();
          ejecutar();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/$icono.svg',
              color: HexColor(negro),
              width: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              texto,
              style: TextStyle(
                color: HexColor(negro),
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
