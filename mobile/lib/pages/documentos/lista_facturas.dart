import 'package:florei_movil/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ListaFacturas extends StatelessWidget {
  const ListaFacturas({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarFlorei(),
      body: Center(
        child: Text('Facturas Lista'),
      ),
    );
  }
}
