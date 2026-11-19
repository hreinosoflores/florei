import 'package:florei_movil/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ListaBoletas extends StatelessWidget {
  const ListaBoletas({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarFlorei(),
      body: Center(
        child: Text('Boletas Lista'),
      ),
    );
  }
}
