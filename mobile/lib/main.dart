import 'package:florei_movil/pages/productos/productos_pages.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductoProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LuzProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GrupoVentaProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PrecioXGrupoProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TrabajadorProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoriaProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SubCategoriaProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MarcaProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ImagenProvider(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Florei Import SAC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.fjallaOneTextTheme()),
      initialRoute: 'lista_productos',
      routes: obtenerPages(),
      onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
        builder: (context) => const ListaProductos(),
      ),
    );
  }
}
