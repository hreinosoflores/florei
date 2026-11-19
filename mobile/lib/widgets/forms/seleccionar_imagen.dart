import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:florei_movil/global/colors.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class SeleccionarImagen extends StatefulWidget {
  final Function onSelectImage;

  const SeleccionarImagen({
    super.key,
    required this.onSelectImage,
  });

  @override
  State<SeleccionarImagen> createState() => _SeleccionarImagenState();
}

class _SeleccionarImagenState extends State<SeleccionarImagen> {
  File? imageBuscada;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Parrafo(
            color: negro,
            texto: 'Seleccionar Foto',
            alineacion: TextAlign.left,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            BotonDorado(
              ancho: 150,
              icono: 'search-circle',
              texto: 'Buscar',
              isLoading: isLoading,
              ejecutar: () async {
                final ImagePicker picker = ImagePicker();
                isLoading = true;
                if (isLoading) {
                  // ignore: avoid_print
                  print('Cargando');
                }
                // Pick an image
                final XFile? xfile =
                    await picker.pickImage(source: ImageSource.gallery);
                isLoading = false;
                // ignore: avoid_print
                print('Galeria cargada');
                if (xfile != null) {
                  setState(() {
                    imageBuscada = File(xfile.path);
                    widget.onSelectImage(imageBuscada);
                  });
                }
              },
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        DottedBorder(
          color: HexColor(gris),
          strokeWidth: 2,
          dashPattern: const [
            5,
            5,
          ],
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              SizedBox(
                width: double.infinity,
                height: 270,
                child: _mostrarImagen(imageBuscada),
              ),
              Visibility(
                visible: imageBuscada != null,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      imageBuscada = null;
                      widget.onSelectImage(imageBuscada);
                    });
                  },
                  child: SvgPicture.asset(
                    'assets/icons/close-circle.svg',
                    color: HexColor(gris),
                    width: 48,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Image _mostrarImagen(File? file) {
    Image imagen;
    if (file != null) {
      imagen = Image.file(
        file,
        fit: BoxFit.contain,
      );
    } else {
      imagen = Image.asset(
        'assets/img/background_image.png',
        fit: BoxFit.fill,
      );
    }
    return imagen;
  }
}
