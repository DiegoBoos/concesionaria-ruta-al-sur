import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:ruta_al_sur_v2/main.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const SignUpScreen({Key? key, required this.onClickedSignUp})
      : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20),
                        child: Image.asset(
                          'assets/logo-ruta-al-sur.jpeg',
                          height: 150,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Utils.lightGreen, Utils.green]),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          child: Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: Column(
                                children: [
                                  SlideInLeft(
                                      delay: const Duration(milliseconds: 100),
                                      child: _email()),
                                  SlideInRight(
                                      delay: const Duration(milliseconds: 100),
                                      child: _password()),
                                  SlideInLeft(
                                      delay: const Duration(milliseconds: 100),
                                      child: _confirmPassword()),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              const Size.fromHeight(50)),
                                      onPressed: signUp,
                                      child: const Text('Registrarse',
                                          style: TextStyle(fontSize: 24))),
                                  const SizedBox(height: 30),
                                  _login(),
                                  Expanded(child: Container()),
                                  Column(
                                    children: [
                                      Text(
                                        'SIRIS S.A.S',
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: 12),
                                      ),
                                      Text(
                                        'Versión Beta de Junio 2022',
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    bottom: -20,
                    left: -50,
                    child: Icon(
                      Icons.fingerprint,
                      size: 150,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  RichText _login() {
    return RichText(
        text: TextSpan(
            style: const TextStyle(color: Colors.white, fontSize: 15),
            text: 'Iniciar sesión  ',
            children: [
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = widget.onClickedSignUp,
              text: 'Ya tiene una cuenta?',
              style: const TextStyle(
                decoration: TextDecoration.underline,
              ))
        ]));
  }

  TextFormField _email() {
    return TextFormField(
        cursorColor: Colors.white,
        controller: emailController,
        textInputAction: TextInputAction.next,
        decoration: inputDecoration(
            'Correo electrónico', Icons.person_outline_outlined),
        style: const TextStyle(color: Colors.white),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (email) {
          if (email != null && !email.contains('@rutaalsur.co')) {
            return 'Correo no válido';
          }
          return null;
        });
  }

  TextFormField _password() {
    return TextFormField(
        cursorColor: Colors.white,
        obscureText: _obscureText,
        controller: passwordController,
        decoration: inputDecoration('Contraseña', Icons.lock, true),
        style: const TextStyle(color: Colors.white),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (password) =>
            password != null && passwordController.text.length < 6
                ? 'Ingrese como mínimo 6 caracteres'
                : null);
  }

  TextFormField _confirmPassword() {
    return TextFormField(
        cursorColor: Colors.white,
        obscureText: _obscureText,
        decoration: inputDecoration('Confirmar Contraseña', Icons.lock, true),
        style: const TextStyle(color: Colors.white),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (confirmPassword) {
          if (confirmPassword != null && passwordController.text.length < 6) {
            return 'Ingrese como mínimo 6 caracteres';
          }

          if (passwordController.text != confirmPassword) {
            return 'Las contraseñas no coinciden';
          }

          return null;
        });
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  InputDecoration inputDecoration(String labelText, IconData icon,
      [bool isPassword = false]) {
    return InputDecoration(
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Utils.yellow, width: 2),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Utils.yellow, width: 2),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      labelStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      errorStyle: const TextStyle(color: Utils.yellow),
      prefixIcon: Icon(icon, color: Colors.white),
      suffixIcon: isPassword
          ? IconButton(
              onPressed: _toggle,
              icon: _obscureText
                  ? const Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                    )
                  : const FaIcon(
                      FontAwesomeIcons.eyeSlash,
                      color: Colors.white,
                      size: 18,
                    ))
          : null,
      labelText: labelText,
    );
  }
}
