import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppBarFlorei extends StatelessWidget implements PreferredSizeWidget {
  const AppBarFlorei({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      backgroundColor: HexColor(blanco),
      automaticallyImplyLeading: false,
      title: Image.asset(
        'assets/img/logo.jpeg',
        width: 240,
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: Menu(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
