import 'package:florei_movil/global/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class InputForm extends StatelessWidget {
  final TextEditingController? controlador;
  final String? valorInicial;
  final void Function(String) cambiando;
  final String? Function(String?) validando;
  final TextInputType? tipoTeclado;
  final List<TextInputFormatter>? formateoLista;
  final String placeholder;

  const InputForm({
    super.key,
    this.controlador,
    this.valorInicial,
    required this.cambiando,
    required this.validando,
    this.tipoTeclado,
    this.formateoLista,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
      child: TextFormField(
        controller: controlador,
        initialValue: valorInicial,
        onChanged: cambiando,
        validator: validando,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: tipoTeclado,
        inputFormatters: formateoLista,
        style: TextStyle(
          fontSize: 18,
          color: HexColor(negro),
        ),
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: HexColor(gris),
          ),
          border: InputBorder.none,
          errorStyle: const TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
