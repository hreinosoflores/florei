import 'package:florei_movil/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ListaTrabajadores extends StatelessWidget {
  const ListaTrabajadores({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarFlorei(),
      body: Center(
        child: Text('Trabajadores Lista'),
      ),
    );
  }
}
