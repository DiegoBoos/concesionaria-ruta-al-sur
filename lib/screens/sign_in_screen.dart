import 'package:animate_do/animate_do.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ruta_al_sur_v2/main.dart';
import 'package:ruta_al_sur_v2/screens/forgot_pwd_screen.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const SignInScreen({Key? key, required this.onClickedSignIn})
      : super(key: key);

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
                                  _register(),
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

  RichText _register() {
    return RichText(
        text: TextSpan(
            text: 'Registrarse  ',
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
            children: [
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = widget.onClickedSignIn,
              text: 'No tiene una cuenta?',
              style: const TextStyle(
                decoration: TextDecoration.underline,
              ))
        ]));
  }

  Align _forgotPassword(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
          child: const Text('Olvidó su contraseña?',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                  fontSize: 15)),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ForgotPwdScreen()))),
    );
  }

  TextFormField _email() {
    return TextFormField(
      controller: emailController,
      cursorColor: Colors.white,
      textInputAction: TextInputAction.next,
      decoration:
          inputDecoration('Correo electrónico', Icons.person_outline_outlined),
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
      decoration: inputDecoration('Contraseña', Icons.lock, true),
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
              icon: !_obscureText
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
