import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components/rounded_button.dart';
import 'components/rounded_text_field.dart';
import 'home_screen.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = 'singup';

  SignUpScreen({
    super.key,
  });

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9d1534),
      appBar: AppBar(
        title: Text('Cadastro'),
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
                text: "Registar",
                onPressed: () => createUser(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  void createUser(BuildContext context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((userCredential) {
      print("Logou com sucesso!");
      Navigator.restorablePushReplacementNamed(context, HomeScreen.id);
    }).catchError((error) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredential) {
        print("Cadastrou com sucesso!");
      }).catchError((error) {
        print("Erro ao autenticar!");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message)));
      });
    });
  }
}
