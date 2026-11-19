import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/models/models.dart';
import 'package:florei_movil/providers/providers.dart';
import 'package:florei_movil/widgets/titulos/parrafo.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AuditoriaInfo extends StatelessWidget {
  final Auditoria auditoria;
  const AuditoriaInfo({
    super.key,
    required this.auditoria,
  });

  @override
  Widget build(BuildContext context) {
    DateFormat dateformat = DateFormat("dd/MM/yyyy hh:mm:ss aaa");

    List<Trabajador> trabajadores = Provider.of<TrabajadorProvider>(
      context,
    ).trabajadores;

    Iterable<Trabajador> usuarioCreacion =
        trabajadores.where((trab) => trab.id == auditoria.usuarioCreacion);

    Iterable<Trabajador> usuarioModificacion =
        trabajadores.where((trab) => trab.id == auditoria.usuarioModificacion);

    String usuarioCreacionNombres = usuarioCreacion.isNotEmpty
        ? '${usuarioCreacion.first.peNatural.nombres} ${usuarioCreacion.first.peNatural.apellidos != null ? usuarioCreacion.first.peNatural.apellidos! : ''}'
        : 'Sin Datos';

    String usuarioModificacionNombres = usuarioModificacion.isNotEmpty
        ? '${usuarioModificacion.first.peNatural.nombres} ${usuarioModificacion.first.peNatural.apellidos != null ? usuarioModificacion.first.peNatural.apellidos! : ''}'
        : 'Sin Datos';

    String fechaCreacionStr = auditoria.fechaCreacion != null
        ? dateformat.format(
            auditoria.fechaCreacion!.add(
              const Duration(
                hours: -5,
              ),
            ),
          )
        : 'Sin datos';

    String fechaModificacionStr = auditoria.fechaModificacion != null
        ? dateformat.format(
            auditoria.fechaModificacion!.add(
              const Duration(
                hours: -5,
              ),
            ),
          )
        : 'Sin datos';

    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: HexColor(gris),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Parrafo(
              color: naranjaOscuro,
              texto: 'Auditoría',
              alineacion: TextAlign.left,
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: Parrafo(
              color: negro,
              texto: 'Fecha de creación:',
              alineacion: TextAlign.left,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Parrafo(
              color: negro,
              texto: fechaCreacionStr,
              alineacion: TextAlign.left,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Parrafo(
              color: negro,
              texto: 'Usuario Creación:',
              alineacion: TextAlign.left,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Parrafo(
              color: negro,
              texto: usuarioCreacionNombres,
              alineacion: TextAlign.left,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Parrafo(
              color: negro,
              texto: 'Fecha última modificación:',
              alineacion: TextAlign.left,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Parrafo(
              color: negro,
              texto: fechaModificacionStr,
              alineacion: TextAlign.left,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Parrafo(
              color: negro,
              texto: 'Usuario Última Modificación:',
              alineacion: TextAlign.left,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Parrafo(
              color: negro,
              texto: usuarioModificacionNombres,
              alineacion: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
