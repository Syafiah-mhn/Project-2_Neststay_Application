import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:testpro2/model/customer.dart';

class MyAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
        backgroundColor: Colors.purple,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: MyAccountWidget(),
    );
  }
}

class MyAccountWidget extends StatefulWidget {
  @override
  _MyAccountWidgetState createState() => _MyAccountWidgetState();
}

class _MyAccountWidgetState extends State<MyAccountWidget> {
  late Future<User?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _fetchUserData();
  }

  Future<User?> _fetchUserData() async {
    final url = Uri.https(
      'neststayapp-default-rtdb.asia-southeast1.firebasedatabase.app',
      'hotel-app.json',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Replace 'userIdentifier' with the actual identifier you want to use
        final userData = data['userIdentifier']; // Replace with the actual identifier

        if (userData != null) {
          return User.fromJson(userData);
        } else {
          return null; // User not found
        }
      } else {
        throw Exception('Failed to load user data. HTTP Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == null) {
          return Text('User not found'); // Handle the case where no user data is found
        } else {
          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Username: ${user.username}'),
                Text('Full Name: ${user.name}'),
                Text('Email: ${user.email}'),
                Text('Password: ${user.password ?? 'N/A'}'),
              ],
            ),
          );
        }
      },
    );
  }
}
