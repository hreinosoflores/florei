import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class DropDownCategorias extends StatefulWidget {
  final Categoria categoria;
  const DropDownCategorias({super.key, required this.categoria});

  @override
  State<DropDownCategorias> createState() => _DropDownCategoriasState();
}

class _DropDownCategoriasState extends State<DropDownCategorias> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final categoriasProvider =
          Provider.of<CategoriaProvider>(context, listen: false);
      await categoriasProvider.cargarCategorias();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoriasProvider = Provider.of<CategoriaProvider>(context);

    final List<Categoria> categorias = categoriasProvider.categorias;

    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: HexColor(blanco),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: HexColor(negro).withValues(alpha: (0.3 * 255)),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<int>(
          value: widget.categoria.id == 0 ? null : widget.categoria.id,
          hint: Parrafo(
            color: gris,
            texto: 'Seleccione Tipo de Producto',
            alineacion: TextAlign.left,
          ),
          menuMaxHeight: 250,
          validator: (value) => value == null ? 'Campo Obligatorio' : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            border: InputBorder.none,
            errorStyle: TextStyle(
              fontSize: 18.0,
            ),
          ),
          dropdownColor: HexColor(blanco),
          elevation: 0,
          isExpanded: true,
          items: categorias
              .map(
                (categoria) => DropdownMenuItem(
                  value: categoria.id,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: HexColor(gris).withValues(alpha: (0.3 * 255)),
                          width: 0,
                        ),
                      ),
                    ),
                    child: Parrafo(
                      color: negro,
                      texto: categoria.descripcion,
                      alineacion: TextAlign.left,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              if (value != null) {
                widget.categoria.id = value;
              } else {
                // ignore: avoid_print
                print('dropdown valor nulo');
              }
            });
          },
        ),
      ),
    );
  }
}
