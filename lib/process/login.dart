import 'package:flutter/material.dart';
import 'package:testpro2/nav_bar/BottomTabScreen.dart';
import 'signup.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:testpro2/model/cust_details.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String userid = "";
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  void _signIn(BuildContext context) async {
    final url = Uri.https(
      'neststayapp-default-rtdb.asia-southeast1.firebasedatabase.app',
      'hotel-app.json',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      print('Fetched data: $data');

      final username = _usernameController.text;
      final password = _passwordController.text;

       // Check if the username exists in the data
      if (data.values.any((user) => user['username'] == username && user['password'] == password)) {
        // Successful login, navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomTabScreen(username: username),
          ),
          
        );
      } else {
        // Display validation error message for unsuccessful login
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid username or password. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      // Handle HTTP request error
      print('Failed to fetch data. HTTP Status Code: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to fetch data. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back, 
            color: Colors.white
            ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/intro.png', // Replace with the path to your image asset
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          // Transparent Container Overlay
          Container(
            color: Colors.black.withOpacity(0.4), // Adjust opacity as needed
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Sign in with your username and password',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.white.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.lock),
                          title: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final usernameError = _validateUsername(_usernameController.text);
                    final passwordError = _validatePassword(_passwordController.text);

                    if (usernameError == null && passwordError == null) {
                      // Both username and password are valid, perform login
                      _signIn(context);
                    } else {
                      // Display validation error messages
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(usernameError ?? passwordError ?? 'Please enter valid credentials'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple, // Adjust button color here
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                    child: const Text(
                      'Log in',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Signup now',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
