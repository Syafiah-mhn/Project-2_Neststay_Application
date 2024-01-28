// room.dart

class Room {
  final int id;
  final String name;
  final List<String> facilities;
  final int noOfPeople;
  final String imageUrl;
  final double price;

  Room({
    required this.id,
    required this.name,
    required this.facilities,
    required this.noOfPeople,
    required this.imageUrl,
    required this.price,
  });
}
