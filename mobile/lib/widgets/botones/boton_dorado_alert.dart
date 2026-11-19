import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class BotonDoradoAlert extends StatelessWidget {
  final String texto;
  final Function ejecutar;

  const BotonDoradoAlert({
    super.key,
    required this.texto,
    required this.ejecutar,
  });

  @override
  Widget build(BuildContext context) {
    final productoProvider = Provider.of<ProductoProvider>(context);

    return ElevatedButton(
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
      onPressed: productoProvider.isLoading ? null : () => ejecutar(),
      child: Text(
        texto,
        style: TextStyle(
          color: HexColor(negro),
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
