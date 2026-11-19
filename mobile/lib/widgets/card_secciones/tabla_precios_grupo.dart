import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class TablaPreciosGrupo extends StatelessWidget {
  final Producto producto;

  const TablaPreciosGrupo({
    super.key,
    required this.producto,
  });

  @override
  Widget build(BuildContext context) {
    var header = TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Parrafo(
            color: naranjaOscuro,
            texto: 'Grupo Venta',
            alineacion: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Parrafo(
            color: naranjaOscuro,
            texto: 'Precio Unidad',
            alineacion: TextAlign.center,
          ),
        ),
      ],
    );

    List<TableRow> tableRows = [];
    tableRows.add(header);
    tableRows.addAll(getTableData(context));

    return Table(
      border: TableBorder.all(
        color: HexColor(gris),
        width: 2.0,
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: tableRows,
    );
  }

  Iterable<TableRow> getTableData(BuildContext context) {
    List<GrupoVenta> gruposVentaBD = Provider.of<GrupoVentaProvider>(
      context,
    ).gruposVenta;

    List<PrecioXGrupo> preciosXGrupos = Provider.of<PrecioXGrupoProvider>(
      context,
    ).preciosXGrupos;

    Iterable<TableRow> rows = gruposVentaBD.map(
      (gv) {
        Iterable<PrecioXGrupo> precioXGrupo = preciosXGrupos.where(
          (pg) => pg.grupoVenta.id == gv.id && pg.producto.id == producto.id,
        );
        String precioStr = precioXGrupo.isNotEmpty
            ? 'S/. ${precioXGrupo.first.valorSoles.toStringAsFixed(2)}'
            : '--';
        return TableRow(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
              child: Parrafo(
                color: negro,
                texto: gv.descripcion,
                alineacion: TextAlign.center,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
              child: Parrafo(
                color: negro,
                texto: precioStr,
                alineacion: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );

    return rows;
  }
}
