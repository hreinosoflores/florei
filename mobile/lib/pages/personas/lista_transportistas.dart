import 'package:florei_movil/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ListaTransportistas extends StatelessWidget {
  const ListaTransportistas({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarFlorei(),
      body: Center(
        child: Text('Transportistas Lista'),
      ),
    );
  }
}
