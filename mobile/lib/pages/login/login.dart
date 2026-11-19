import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      child: const _LoginPage(),
    );
  }
}

class _LoginPage extends StatelessWidget {
  const _LoginPage();

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    List<Widget> formRows = [];

    formRows.add(
      Image.asset(
        'assets/img/logo.jpeg',
        width: 300,
      ),
    );

    formRows.add(
      const SizedBox(
        height: 10,
      ),
    );

    formRows.add(
      const Bold30RojoTitulo(texto: "Iniciar Sesión"),
    );

    formRows.add(
      const SizedBox(
        height: 30,
      ),
    );

    formRows.addAll(
      LoginFormInputGroup(
        loginForm,
      ).buildGroup(context),
    );

    formRows.add(
      const SizedBox(
        height: 20,
      ),
    );

    formRows.add(
      BotonDorado(
        ancho: 280,
        icono: 'log-in',
        texto: 'Ingresar',
        ejecutar: () async {
          if (!loginForm.isValidForm()) return;

          loginForm.isLoading = true;

          //Mostrar alert cargando
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => _alertCargando(),
          );

          final loginProvider = Provider.of<LoginProvider>(
            context,
            listen: false,
          );

          String? resultado = await loginProvider.login(
            loginForm.user,
            loginForm.password,
          );

          loginForm.isLoading = false;

          if (resultado == null) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                'lista_productos', (Route<dynamic> route) => false);
          } else {
            llamarAlertError(
              context,
              resultado,
            );
          }
        },
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Form(
              key: loginForm.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: formRows,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _alertCargando() => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Parrafo(
          color: rojo,
          alineacion: TextAlign.center,
          texto: 'Validando Credenciales',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Parrafo(
              color: negro,
              alineacion: TextAlign.center,
              texto:
                  'Por favor, no cierre esta aplicación hasta que finalice la tarea..',
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/img/loading.gif',
                width: 120,
                height: 90,
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
        titlePadding: const EdgeInsets.only(
          top: 10,
          bottom: 5,
          right: 10,
          left: 10,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
      );

  void llamarAlertError(
    BuildContext context,
    String resultado,
  ) {
    //Cerrando alert de confirmar
    Navigator.of(context).pop();
    //Mostrar alert de resultado
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Parrafo(
          color: rojo,
          alineacion: TextAlign.center,
          texto: 'No se pudo iniciar sesión',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: Parrafo(
                color: negro,
                alineacion: TextAlign.left,
                texto: resultado,
              ),
            ),
          ],
        ),
        actions: [
          BotonDoradoAlert(
            texto: 'Ok',
            ejecutar: () => Navigator.of(context).pop(),
          ),
        ],
        titlePadding: const EdgeInsets.only(
          top: 10,
          bottom: 5,
          right: 10,
          left: 10,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
      ),
    );
  }
}
