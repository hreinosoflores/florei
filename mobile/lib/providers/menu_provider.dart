import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

class _MenuProvider {
  List<MenuOpt> menuOptions = [];
  Future<List<MenuOpt>> cargarMenu(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final String response;

    if (await loginProvider.validarUsuarioSesion()) {
      response = await rootBundle.loadString('assets/data/menu.json');
    } else {
      response = await rootBundle.loadString('assets/data/menu-no-login.json');
    }

    menuOptions = menuFromJson(response);
    return menuOptions;
  }
}

final menuProv = _MenuProvider();
