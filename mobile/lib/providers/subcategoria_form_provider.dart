import 'package:florei_movil/models/models.dart';
import 'package:flutter/cupertino.dart';

class SubCategoriaFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SubCategoria subcategoria;

  SubCategoriaFormProvider({
    required this.subcategoria,
  });

  bool isValidForm() => formKey.currentState?.validate() ?? false;
}
