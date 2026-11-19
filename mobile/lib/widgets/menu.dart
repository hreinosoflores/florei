import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/menu_provider.dart';
import 'package:florei_movil/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MenuOpt>>(
      future: menuProv.cargarMenu(context),
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot<List<MenuOpt>> snapshot) {
        return PopupMenuButton(
          child: Icon(
            Icons.menu,
            color: HexColor(verdeBosque),
            size: 30,
          ),
          itemBuilder: (context) {
            List<PopupMenuItem> items = [];
            for (var opt in snapshot.data!) {
              items.addAll(menuGroup(opt, context));
            }
            return items;
          },
          onSelected: (value) {
            if (obtenerPages().containsKey(value.toString())) {
              Navigator.pushNamed(context, value.toString());
            }
          },
        );
      },
    );
  }
}

PopupMenuItem menuItem(MenuOpt menuOpt, BuildContext context) {
  return PopupMenuItem(
    value: menuOpt.url,
    height: 18,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
    child: Row(
      children: [
        SvgPicture.asset(
          'assets/icons/${menuOpt.icon}.svg',
          color: HexColor(verdeBosque),
          width: 24,
        ),
        const SizedBox(width: 8),
        Text(menuOpt.label),
      ],
    ),
  );
}

PopupMenuItem menuSubitem(Subitem subitem, BuildContext context) {
  return PopupMenuItem(
    value: subitem.url,
    height: 18,
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    child: Row(
      children: [
        const SizedBox(width: 30),
        Text(subitem.label),
      ],
    ),
  );
}

List<PopupMenuItem> menuGroup(MenuOpt menuOpt, BuildContext context) {
  List<PopupMenuItem> group = [];
  group.add(menuItem(menuOpt, context));
  if (menuOpt.subitems != []) {
    for (var subitem in menuOpt.subitems) {
      group.add(menuSubitem(subitem, context));
    }
  }
  return group;
}
