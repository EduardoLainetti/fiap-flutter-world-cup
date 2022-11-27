import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalhofinalflutter/models/team_model.dart';
import 'package:trabalhofinalflutter/screens/groups_screen.dart';
import 'package:trabalhofinalflutter/screens/login_screen.dart';

import 'package:http/http.dart';
import '../models/group_model.dart';
import 'components/rounded_button.dart';
import 'matches_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home';

  HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9d1534),
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Menu',
                style: TextStyle(
                  fontSize: 26,
                  color: Color(0xffa5a2a0),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 32,
              ),
              RoundedButton(
                text: 'Grupos',
                onPressed: () {
                  Navigator.pushNamed(context, GroupsScreen.id);
                },
              ),
              SizedBox(
                height: 16,
              ),
              RoundedButton(
                text: 'Partidas',
                onPressed: () {
                  Navigator.pushNamed(context, MatchesScreen.id);
                },
              ),
              SizedBox(
                height: 16,
              ),
              RoundedButton(
                text: "Sair",
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(
                    context,
                    LoginScreen.id,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}