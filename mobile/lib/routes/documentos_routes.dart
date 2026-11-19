import 'package:florei_movil/pages/documentos/documentos_pages.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> documentosPages() {
  return <String, WidgetBuilder>{
    'lista_cotizaciones': (context) => const ListaCotizaciones(),
    'lista_facturas': (context) => const ListaFacturas(),
    'lista_guias_remision': (context) => const ListaGuiasRemision(),
    'lista_boletas': (context) => const ListaBoletas(),
  };
}
