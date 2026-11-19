import 'package:florei_movil/pages/productos/productos_pages.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> productosPages() {
  return <String, WidgetBuilder>{
    'lista_productos': (context) => const ListaProductos(),
    'lista_categorias': (context) => const ListaCategorias(),
    'lista_subcategorias': (context) => const ListaSubcategorias(),
    'lista_marcas': (context) => const ListaMarcas(),
    'lista_grupos_venta': (context) => const ListaGruposVenta(),
    'detalle_producto': (context) => const DetalleProducto(),
    'seleccionar_categorias': (context) => const SelecccionarCategorias(),
    'seleccionar_subcategorias': (context) => const SeleccionarSubcategorias(),
    'seleccionar_marcas': (context) => const SelecccionarMarcas(),
    'save_producto_form': (context) => const SaveProductoForm(),
    'save_categoria_form': (context) => const SaveCategoriaForm(),
    'detalle_categoria': (context) => const DetalleCategoria(),
    'save_subcategoria_form': (context) => const SaveSubCategoriaForm(),
    'detalle_subcategoria': (context) => const DetalleSubCategoria(),
    'save_marca_form': (context) => const SaveMarcaForm(),
    'detalle_marca': (context) => const DetalleMarca(),
  };
}
