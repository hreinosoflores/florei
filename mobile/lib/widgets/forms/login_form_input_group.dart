import 'package:florei_movil/providers/login_form_provider.dart';
import 'package:florei_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginFormInputGroup {
  LoginFormProvider loginForm;

  LoginFormInputGroup(
    this.loginForm,
  );

  List<Widget> buildGroup(BuildContext context) {
    return [
      SizedBox(
        width: double.infinity,
        child: InputForm(
          cambiando: (value) => loginForm.user = value,
          validando: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo Obligatorio';
            }
            return null;
          },
          formateoLista: [
            FilteringTextInputFormatter.allow(
              RegExp(r'[^\.\#\*\$\%\&\|\°\{\}\[\]\?\¡\¿\!\/\=\+\\]+'),
            ),
          ],
          placeholder: 'Ingrese aquí su Id. de Usuario Florei',
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      SizedBox(
        width: double.infinity,
        child: InputPassword(
          cambiando: (value) => loginForm.password = value,
          validando: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo Obligatorio';
            }
            return null;
          },
          placeholder: 'Ingrese aquí su Contraseña',
        ),
      ),
    ];
  }
}
