import 'package:florei_movil/pages/login/logout.dart';
import 'package:florei_movil/pages/login/login.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> loginPages() {
  return <String, WidgetBuilder>{
    'login': (context) => const LoginPage(),
    'logout': (context) => const LogoutPage(),
  };
}
