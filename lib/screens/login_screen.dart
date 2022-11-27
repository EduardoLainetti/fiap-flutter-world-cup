import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalhofinalflutter/screens/home_screen.dart';
import 'package:trabalhofinalflutter/screens/signup_screen.dart';

import 'components/rounded_button.dart';
import 'components/rounded_button_secondary.dart';
import 'components/rounded_text_field.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login';

  LoginScreen({
    super.key,
  });

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9d1534),
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedTextField(
                  text: 'Email',
                  onChanged: (value) {
                    email = value;
                  }),
              SizedBox(
                height: 16,
              ),
              RoundedTextField(
                text: 'Senha',
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
              ),
              SizedBox(
                height: 16,
              ),
              RoundedButton(
                text: "Entrar",
                onPressed: () => authenticateUser(context),
              ),
              SizedBox(
                height: 16,
              ),
              RoundedButtonSecondary(
                text: "Cadastro",
                onPressed: () {
                  Navigator.pushNamed(context, SignUpScreen.id);
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  void authenticateUser(BuildContext context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((userCredential) {
      print("Logou com sucesso!");
      Navigator.restorablePushReplacementNamed(context, HomeScreen.id);
    }).catchError((error) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email,
          password: password
      ).then((userCredential) {
        print("Cadastrou com sucesso!");
      }).catchError((error) {
        print("Erro ao autenticar!");
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message))
        );
      });
    });
  }
}