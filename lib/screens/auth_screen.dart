import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/screens/sign_in_screen.dart';
import 'package:ruta_al_sur_v2/screens/sign_up_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? SignInScreen(onClickedSignIn: toggle)
      : SignUpScreen(onClickedSignUp: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
