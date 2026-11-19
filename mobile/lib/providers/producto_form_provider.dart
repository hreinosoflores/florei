import 'package:florei_movil/models/models.dart';
import 'package:flutter/cupertino.dart';

class ProductoFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Producto producto;

  List<PrecioXGrupo> preciosXGrupo;

  Luz? luz;

  ProductoFormProvider({
    required this.producto,
    required this.preciosXGrupo,
    this.luz,
  });

  bool isValidForm() => formKey.currentState?.validate() ?? false;
}
