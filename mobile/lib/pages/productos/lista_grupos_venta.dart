import 'package:florei_movil/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ListaGruposVenta extends StatelessWidget {
  const ListaGruposVenta({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarFlorei(),
      body: Center(
        child: Text('Grupos Venta Lista'),
      ),
    );
  }
}
