import 'dart:async';
import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/titulos/parrafo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  void initState() {
    super.initState();
    _borrarDatosSesion();
    _irAListaProductos();
  }

  _borrarDatosSesion() async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    await loginProvider.logout();
  }

  _irAListaProductos() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          'lista_productos', (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Parrafo(
                color: negro,
                texto: 'Cerrando Sesión ... ',
                alineacion: TextAlign.center),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/img/loading.gif',
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
    );
  }
}
