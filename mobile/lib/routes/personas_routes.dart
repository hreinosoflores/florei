import 'package:florei_movil/pages/personas/personas_pages.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> personasPages() {
  return <String, WidgetBuilder>{
    'lista_clientes_naturales': (context) => const ListaClientesNaturales(),
    'lista_clientes_juridicos': (context) => const ListaClientesJuridicos(),
    'lista_trabajadores': (context) => const ListaTrabajadores(),
    'lista_transportistas': (context) => const ListaTransportistas(),
    'lista_proovedores': (context) => const ListaProveedores(),
  };
}
