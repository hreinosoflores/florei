import 'package:florei_movil/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ListaClientesNaturales extends StatelessWidget {
  const ListaClientesNaturales({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarFlorei(),
      body: Center(
        child: Text('Clientes Naturales Lista'),
      ),
    );
  }
}
