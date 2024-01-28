import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:testpro2/booking/viewhotelscreen.dart';

class Hotel {
  final String name;
  final String image;
  final String location;

  Hotel({required this.name, required this.image, required this.location});
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  late AnimationController _animationController;
  final double sliderImageHeight = 200.0;

  final List<Hotel> _hotels = [
    Hotel(
        name: 'Grand Sylhet',
        image: 'assets/images/hotel_1.jpg',
        location: 'Central Area, Sylhet'),
    Hotel(
        name: 'Grand Culton',
        image: 'assets/images/hotel_2.png',
        location: 'Sylhet'),
    Hotel(
        name: 'Sreemangal Rapid',
        image: 'assets/images/hotel_3.png',
        location: 'Sreemangal'),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F7FF),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: ListView(
          children: [
            SizedBox(height: 20.0),
            Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(30.0),
              shadowColor: Color(0x55434343),
              child: TextField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search for Hotel",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.purple,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            // Slide images of countries
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                var opacity = 1.0 - (_animationController.value > 0.64 ? 1.0 : _animationController.value);
                return SizedBox(
                  height: sliderImageHeight * (1.0 - _animationController.value),
                  child: Stack(
                    children: [
                      CarouselSlider(
                        items: [
                          Image.asset('assets/images/popular_1.jpg'),
                          Image.asset('assets/images/popular_2.jpg'),
                          Image.asset('assets/images/popular_3.jpg'),
                          Image.asset('assets/images/popular_4.jpg'),
                          Image.asset('assets/images/popular_5.jpg'),
                          // Add more images as needed
                        ],
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayInterval: Duration(seconds: 1000),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          enableInfiniteScroll: true,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          //color: Colors.black.withOpacity(opacity),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Separation line
            Container(
              height: 2,
              color: Colors.grey,
            ),
            // Near You Section
            _buildSection(
              title: 'Near You',
              hotels: _hotels,
              isNearYou: true,
            ),
            // Most Visited Section
            _buildSection(
              title: 'Most Visited',
              hotels: _hotels,
              isNearYou: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Hotel> hotels, required bool isNearYou}) {
    return Column(
      children: [
        // Section Title
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewHotelPage()),
                  );
                },
                child: Text('View All'),
              ),
            ],
          ),
        ),
        // Hotel List
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hotels.length,
            itemBuilder: (context, index) {
              final hotel = hotels[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to the hotel details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewHotelPageScreen(hotel: hotel),
                    ),
                  );
                },
                child: Card(
                  child: Container(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(hotel.image, height: 100, width: 150, fit: BoxFit.cover),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            hotel.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(hotel.location),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ViewHotelPageScreen extends StatelessWidget {
  final Hotel hotel;

  ViewHotelPageScreen({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(hotel.image, height: 200, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    hotel.location,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  // Add more details as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
