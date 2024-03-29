import 'package:testpro2/model/room.dart';

final List<Room> rooms = [
  Room(
    id: 1,
    name: 'Queen Room',
    facilities: [
      'Queen-sized bed',
      'Private bathroom',
      'Wi-Fi',
      'TV',
      'Air conditioning',
    ],
    noOfPeople: 2,
    imageUrl: 'assets/images/hotel_room_1.jpg',
    price: 150.0,
  ),
  Room(
    id: 2,
    name: 'Deluxe Room',
    facilities: [
      'King-sized bed',
      'Private bathroom with jacuzzi',
      'Wi-Fi',
      'Smart TV',
      'Mini-bar',
      'Air conditioning',
    ],
    noOfPeople: 2,
    imageUrl: 'assets/images/hotel_room_2.jpg',
    price: 250.0,
  ),
  Room(
    id: 3,
    name: 'Premium Room',
    facilities: [
      'Two queen-sized beds',
      'Private balcony',
      'Wi-Fi',
      'Flat-screen TV',
      'Mini-fridge',
      'Air conditioning',
    ],
    noOfPeople: 4,
    imageUrl: 'assets/images/hotel_room_3.jpg',
    price: 350.0,
  ),
  Room(
    id: 4,
    name: 'Executive Suite',
    facilities: [
      'King-sized bed',
      'Spacious living area',
      'Private bathroom with sauna',
      'Wi-Fi',
      'Smart TV',
      'Mini-bar',
      'Air conditioning',
    ],
    noOfPeople: 2,
    imageUrl: 'assets/images/hotel_room_4.jpg',
    price: 500.0,
  ),
  Room(
    id: 5,
    name: 'Family Suite',
    facilities: [
      'Two bedrooms',
      'King-sized bed and two twin beds',
      'Kitchenette',
      'Wi-Fi',
      'Flat-screen TV',
      'Air conditioning',
    ],
    noOfPeople: 4,
    imageUrl: 'assets/images/hotel_room_5.jpg',
    price: 450.0,
  ),
  Room(
    id: 6,
    name: 'Presidential Suite',
    facilities: [
      'Luxurious king-sized bed',
      'Private elevator access',
      'Spa and sauna',
      'Private cinema',
      'Wi-Fi',
      'Smart TV',
      'Mini-bar',
      'Air conditioning',
    ],
    noOfPeople: 2,
    imageUrl: 'assets/images/hotel_room_7.jpg',
    price: 1000.0,
  ),
];
