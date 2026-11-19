import 'package:florei_movil/routes/documentos_routes.dart';
import 'package:florei_movil/routes/login_routes.dart';
import 'package:florei_movil/routes/personas_routes.dart';
import 'package:florei_movil/routes/productos_routes.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> obtenerPages() {
  Map<String, WidgetBuilder> routeMap = {};
  productosPages().forEach((key, value) => routeMap[key] = value);
  documentosPages().forEach((key, value) => routeMap[key] = value);
  personasPages().forEach((key, value) => routeMap[key] = value);
  loginPages().forEach((key, value) => routeMap[key] = value);

  return routeMap;
}
