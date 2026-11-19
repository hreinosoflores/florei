import 'package:florei_movil/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ListaCotizaciones extends StatelessWidget {
  const ListaCotizaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarFlorei(),
      body: Center(
        child: Text('Cotizaciones Lista'),
      ),
    );
  }
}
