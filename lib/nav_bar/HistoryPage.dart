import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<dynamic> bookingHistory = [];

  @override
  void initState() {
    super.initState();
    // Fetch booking history from Firebase
    _fetchBookingHistory();
  }

  Future<void> _fetchBookingHistory() async {
    try {
      final url = Uri.https(
        'neststayapp-default-rtdb.asia-southeast1.firebasedatabase.app',
        'hotel-bookings.json',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the response body
        final Map<String, dynamic> data = json.decode(response.body);
        // Convert data map to a list of bookings
        final List<dynamic> history = data.values.toList();

        setState(() {
          bookingHistory = history;
        });
      } else {
        // Handle HTTP request error
        print('Failed to fetch booking history. HTTP Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching booking history: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: bookingHistory.length,
        itemBuilder: (context, index) {
          // Use the data in bookingHistory to build your list items
          // You can create a custom widget or ListTile based on your data structure
          return ListTile(
            title: Text('Hotel: ${bookingHistory[index]['hotelName']}'),
            subtitle: Text('User: ${bookingHistory[index]['userId']}'),
            // Add more fields as needed
          );
        },
      ),
    );
  }
}
