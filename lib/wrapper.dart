import 'package:admingp2/models/admin.dart';
import 'package:admingp2/screens/authencation/authencation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/launch.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    Admin? user = Provider.of<Admin?>(context);
    if (user == null) {
      return const Authenicate();
    } else {
      return const LaunchPage();
    }
  }
}
