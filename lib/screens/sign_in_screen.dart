import 'package:animate_do/animate_do.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ruta_al_sur_v2/main.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              const Size.fromHeight(50)),
                                      onPressed: signIn,
                                      child: const Text('Iniciar sesión',
                                          style: TextStyle(fontSize: 24))),
                                  const SizedBox(height: 20),
                                  _forgotPassword(context),
                                  const SizedBox(height: 30),
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
                                        'Última versión noviembre 2022',
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

  Align _forgotPassword(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: (() => _dialogBuilder(context)),
        child: const Text('Olvidó su contraseña?',
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.white,
                fontSize: 15)),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Olvidó su contraseña?'),
          content: const Text(
            'Para restablecer su contraseña por favor póngase en contacto con el administrador',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Aceptar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  TextFormField _email() {
    return TextFormField(
      controller: emailController,
      cursorColor: Colors.white,
      textInputAction: TextInputAction.next,
      decoration: inputDecoration(
          'Correo electrónico', Icons.person_outline_outlined, emailController),
      style: const TextStyle(color: Colors.white),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (email) => email != null && !EmailValidator.validate(email)
          ? 'Correo no válido'
          : null,
    );
  }

  TextFormField _password() {
    return TextFormField(
      controller: passwordController,
      cursorColor: Colors.white,
      textInputAction: TextInputAction.done,
      style: const TextStyle(color: Colors.white),
      decoration:
          inputDecoration('Contraseña', Icons.lock, passwordController, true),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (password) =>
          password != null && passwordController.text.length < 6
              ? 'Ingrese como mínimo 6 caracteres'
              : null,
      obscureText: _obscureText,
    );
  }

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  InputDecoration inputDecoration(String labelText, IconData icon,
      TextEditingController textEditingController,
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
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isPassword)
            IconButton(
                onPressed: _toggle,
                icon: !_obscureText
                    ? const Icon(
                        Icons.remove_red_eye,
                        color: Colors.white,
                      )
                    : const FaIcon(
                        FontAwesomeIcons.eyeSlash,
                        color: Colors.white,
                        size: 18,
                      )),
          IconButton(
              onPressed: (() => textEditingController.clear()),
              icon: const Icon(
                Icons.clear,
                color: Colors.white,
              )),
        ],
      ),
      labelText: labelText,
    );
  }
}
