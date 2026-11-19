import 'package:florei_movil/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ListaGuiasRemision extends StatelessWidget {
  const ListaGuiasRemision({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarFlorei(),
      body: Center(
        child: Text('Guias de Remision Lista'),
      ),
    );
  }
}
