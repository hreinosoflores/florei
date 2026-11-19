import 'package:florei_movil/models/models.dart';
import 'package:flutter/cupertino.dart';

class CategoriaFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Categoria categoria;

  CategoriaFormProvider({
    required this.categoria,
  });

  bool isValidForm() => formKey.currentState?.validate() ?? false;
}
