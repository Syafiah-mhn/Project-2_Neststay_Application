import 'package:testpro2/model/room.dart';

class Hotel {
  final int id;
  final String name;
  final String location;
  final String imageUrl;
  final String description;
  final double rating;
  final double price;
  final Room? selectedroom;

  Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.rating,
    this.selectedroom,
  });

 
}

class HotelBooking {
  String location;
  DateTime checkInDate;
  DateTime checkOutDate;
  int numberOfRooms;
  int numberOfAdults;
  int numberOfChildren;
  List<int> childrenAges;

  HotelBooking({
    required this.location,
    required this.checkInDate,
    required this.checkOutDate,
    required this.numberOfRooms,
    required this.numberOfAdults,
    required this.numberOfChildren,
    required this.childrenAges,
  });
}
