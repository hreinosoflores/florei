import 'package:florei_movil/models/models.dart';
import 'package:flutter/cupertino.dart';

class MarcaFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Marca marca;

  MarcaFormProvider({
    required this.marca,
  });

  bool isValidForm() => formKey.currentState?.validate() ?? false;
}
