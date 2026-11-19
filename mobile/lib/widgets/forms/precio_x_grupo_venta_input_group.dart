import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PrecioXGrupoVentaInputGroup {
  List<PrecioXGrupo> preciosXGrupo;

  PrecioXGrupoVentaInputGroup(this.preciosXGrupo);

  Iterable<Widget> buildGroup(BuildContext context) {
    Iterable<Row> rows = preciosXGrupo.map(
      (pg) => Row(
        children: [
          Parrafo(
            color: negro,
            texto: pg.grupoVenta.descripcion,
            alineacion: TextAlign.left,
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Parrafo(
                color: negro,
                texto: 'S/.',
                alineacion: TextAlign.left,
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 150,
                child: InputFormPrecioProducto(
                  valorInicial: pg.valorSoles != 0
                      ? pg.valorSoles.toStringAsFixed(2)
                      : '',
                  cambiando: (value) {
                    if (double.tryParse(value) == null) {
                      pg.valorSoles = 0;
                    } else {
                      pg.valorSoles = double.parse(value);
                    }
                  },
                  validando: (value) {
                    return null;
                  },
                  placeholder: '0.00',
                ),
              )
            ],
          ))
        ],
      ),
    );

    return rows;
  }
}
