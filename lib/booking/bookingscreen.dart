import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:testpro2/model/cust_details.dart';

class HotelBookingScreen extends StatefulWidget {
  @override
  _HotelBookingScreenState createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  TextEditingController locationController = TextEditingController();
  DateTime checkInDate = DateTime.now();
  DateTime checkOutDate = DateTime.now().add(Duration(days: 1));
  int numberOfRooms = 1;
  int numberOfAdults = 1;
  int numberOfChildren = 0;
  List<int> childrenAges = [];

  String? _validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the location';
    }
    return null;
  }

  void _applyBooking(BuildContext context) async {
    final url = Uri.https(
      'neststayapp-default-rtdb.asia-southeast1.firebasedatabase.app', // Replace with your Firebase project ID
      'hotel-bookings.json',
    );

    final response = await http.post(
      url,
      body: json.encode({
        'location': locationController.text,
        'checkInDate': checkInDate.toIso8601String(),
        'checkOutDate': checkOutDate.toIso8601String(),
        'numberOfRooms': numberOfRooms,
        'numberOfAdults': numberOfAdults,
        'numberOfChildren': numberOfChildren,
        'childrenAges': childrenAges,
      }),
    );

    if (response.statusCode == 200) {
      // Successful booking, handle navigation or other logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Booking applied successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Handle HTTP request error
      print('Failed to apply booking. HTTP Status Code: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to apply booking. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Hotel'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Check-in Date'),
                      InkWell(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: checkInDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null && pickedDate != checkInDate) {
                            setState(() {
                              checkInDate = pickedDate;
                            });
                          }
                        },
                        child: Text(
                          '${checkInDate.day}/${checkInDate.month}/${checkInDate.year}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Check-out Date'),
                      InkWell(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: checkOutDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null && pickedDate != checkOutDate) {
                            setState(() {
                              checkOutDate = pickedDate;
                            });
                          }
                        },
                        child: Text(
                          '${checkOutDate.day}/${checkOutDate.month}/${checkOutDate.year}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Number of Rooms'),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (numberOfRooms > 1) {
                      setState(() {
                        numberOfRooms--;
                      });
                    }
                  },
                ),
                Text('$numberOfRooms'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      numberOfRooms++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Number of Adults'),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (numberOfAdults > 1) {
                      setState(() {
                        numberOfAdults--;
                      });
                    }
                  },
                ),
                Text('$numberOfAdults'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      numberOfAdults++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Number of Children'),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (numberOfChildren > 0) {
                      setState(() {
                        numberOfChildren--;
                      });
                    }
                  },
                ),
                Text('$numberOfChildren'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      numberOfChildren++;
                    });
                  },
                ),
              ],
            ),
            if (numberOfChildren > 0) ...[
              SizedBox(height: 16),
              Text('Children Ages'),
              for (int i = 0; i < numberOfChildren; i++) ...[
                Row(
                  children: [
                    Text('Child ${i + 1}:'),
                    SizedBox(width: 8),
                    DropdownButton<int>(
                      value: childrenAges.isEmpty ? null : childrenAges[i],
                      hint: Text('Age'),
                      onChanged: (value) {
                        setState(() {
                          if (childrenAges.length <= i) {
                            childrenAges.add(value!);
                          } else {
                            childrenAges[i] = value!;
                          }
                        });
                      },
                      items: List.generate(18, (index) => index + 1)
                          .map((age) => DropdownMenuItem<int>(
                                value: age,
                                child: Text('$age'),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ],
            ],
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final locationError = _validateLocation(locationController.text);

                if (locationError == null) {
                  // Location is valid, perform booking
                  _applyBooking(context);
                } else {
                  // Display validation error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(locationError),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.purple, // Adjust button color here
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30.0),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                child: Text(
                  'Apply',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
