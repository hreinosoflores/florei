import 'package:florei_movil/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ListaClientesJuridicos extends StatelessWidget {
  const ListaClientesJuridicos({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarFlorei(),
      body: Center(
        child: Text('Clientes Juridicos Lista'),
      ),
    );
  }
}
