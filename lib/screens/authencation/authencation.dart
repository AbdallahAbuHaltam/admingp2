import 'package:flutter/material.dart';

import 'login.dart';
import 'signup.dart';

bool showSignin = true;

class Authenicate extends StatefulWidget {
  const Authenicate({super.key});

  @override
  State<Authenicate> createState() => _AuthenicateState();
}

class _AuthenicateState extends State<Authenicate> {
  @override
  Widget build(BuildContext context) {
    if (showSignin) {
      return const Login();
    } else {
      return const Signup();
    }
  }
}
