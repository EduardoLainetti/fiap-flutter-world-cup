import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trabalhofinalflutter/screens/home_screen.dart';
import 'package:trabalhofinalflutter/screens/login_screen.dart';
import 'package:trabalhofinalflutter/screens/signup_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash';

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkForUserWaitRoute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffa5a2a0),
      appBar: AppBar(
        title: Text('Splash'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash.svg.jpg"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  checkForUserWaitRoute() async {
    var duration = new Duration(seconds: 3);
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null) {
      print("User é nulo");
      return Timer(duration, routeLogin);
    } else {
      print("User não é nulo");
      return Timer(duration, routeHome);
    }
  }

  routeLogin() {
    print("VAI ROTEAR PARA A ROTA LOGIN");
    Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

  routeHome() {
    print("VAI ROTEAR PARA A ROTA HOME");
    Navigator.pushReplacementNamed(context, HomeScreen.id);
  }
}
