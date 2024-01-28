import 'package:flutter/material.dart';
import 'package:testpro2/nav_bar/Profile/Body.dart';

class ProfilePage extends StatelessWidget {
  static String routes = '/profile';

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}