// details_room.dart
import 'package:flutter/material.dart';
import 'package:testpro2/model/room.dart';

class DetailsRoom extends StatelessWidget {
  final Room room;

  const DetailsRoom({required this.room, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Details'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add an Image widget for the room's image
            Image.network(
              room.imageUrl,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16.0),
            Text(
              room.name,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            // Add a Text widget for the number of people
            Text(
              "Accommodates ${room.noOfPeople} people",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: room.facilities.map((facility) {
                IconData icon;
                switch (facility.toLowerCase()) {
                  case 'wifi':
                    icon = Icons.wifi;
                    break;
                  case 'tv':
                    icon = Icons.tv;
                    break;
                  case 'ac':
                    icon = Icons.ac_unit;
                    break;
                  default:
                    icon = Icons.help;
                }
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(icon),
                      const SizedBox(width: 4.0),
                      Text(facility),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Price: RM ${room.price.toStringAsFixed(2)} per night",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
