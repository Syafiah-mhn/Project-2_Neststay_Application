import 'package:flutter/material.dart';
import 'package:testpro2/nav_bar/Profile/EditProfile.dart';
import 'package:testpro2/nav_bar/Profile/MyAccountScreen.dart';
import 'package:testpro2/nav_bar/Profile/ProfileMenu.dart';
import 'package:testpro2/nav_bar/Profile/ProfilePic.dart';
import 'package:testpro2/process/login.dart';

class Body extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Column(
      children: [
        ProfilePic(),
        SizedBox(height: 20),
        ProfileMenu(
          icon: Icon(
            Icons.account_circle, 
            size: 22, 
            color: Colors.purple),
          text: "My Account", 
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyAccountScreen()),
            );
          } 
        ),
        ProfileMenu(
          icon: Icon(
            Icons.lock, 
            size: 22, 
            color: Colors.purple),
          text: "Change Password", 
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfileScreen()),
            );
          } 
        ),
        ProfileMenu(
          icon: Icon(
            Icons.exit_to_app, 
            size: 22, 
            color: Colors.purple),
          text: "Logout", 
          press: () {
            // Navigate to login page on press
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }, 
        ),        
      ],
    );
  }
  
}

